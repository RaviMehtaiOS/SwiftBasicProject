//
//  APIManager.swift
//  BasicProject
//
//  Created by Ravi Mehta on 27/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation

class APIManager {
    static let sharedInstance = APIManager()
    private init(){}
    typealias APIResult<T> = (_ T: Decodable) -> ()

    
    func serviceRequest<T: Decodable>(networkObj: NetworkModel, modelObj: T, completion: @escaping APIResult<Any>) {
        switch networkObj.method {
            case Constants.HTTPMethod.GET:
                NetworkManager.sharedInstance.getDataFromServer(networkObj: networkObj) { (data, response, error) in
                    if let _ = error { return }
                    DispatchQueue.main.async {
                        completion(self.validateErrorAndResponseData(data: data, error: error, response: response, modelObj: modelObj))
                    }
                }
            case Constants.HTTPMethod.POST:
                NetworkManager.sharedInstance.postDataToServer(networkObj: networkObj) { (data, response, error) in
                    if let _ = error { return }
                    DispatchQueue.main.async {
                        completion(self.validateErrorAndResponseData(data: data, error: error, response: response, modelObj: modelObj))
                    }
                }
            case Constants.HTTPMethod.DELETE :
                NetworkManager.sharedInstance.deleteDataFromServer(networkObj: networkObj) { (data, response, error) in
                    if let _ = error { return }
                    DispatchQueue.main.async {
                        completion(self.validateErrorAndResponseData(data: data, error: error, response: response, modelObj: modelObj))
                    }
                }
            default: break
        }
    }

    
    fileprivate func validateErrorAndResponseData<T: Decodable>(data: Data?, error: Error?, response: URLResponse?, modelObj: T) -> T? {
        
        //Check for error
        guard error == nil else {
            print(error!)
            showSomethingWrongError()
            return nil
        }
        
        //Making sure we got some data
        guard data != nil else {
            print("Error: did not receive data")
            showSomethingWrongError()
            return nil
        }
        
        //Json to String
        let backToString = String(data: data!, encoding: String.Encoding.utf8)
        print(backToString!)
        
        //Checking the server response code not the API response code
        if let response = response {
            let httpResponse = response as! HTTPURLResponse
            
            
            switch httpResponse.statusCode {
            case 200, 201: //Success
                
                let dictionary = convertToDictionary(text: backToString!)
                
                if(dictionary != nil) {
                    if dictionary!["code"] as? Int64 == 414
                    {
                        showLogoutError()
                        //Handle logout and then return nil
                        
                        return nil
                    }else{
                        
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: data!)
                            return obj
                        }catch let jsonError {
                            print("Failed to decode json: ", jsonError)
                        }
                        
                        
                        return nil
                    }
                }else{
                    let array = convertToArray(text: backToString!)
                    if(array != nil) {
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: data!)
                            return obj
                        }catch let jsonError {
                            print("Failed to decode json: ", jsonError)
                        }
                    }else{
                        showSomethingWrongError()
                        return nil
                    }
                }
                
                
                
            case 400, 403, 404: //Error - May be logged out
                //converting the data to dictionary
                let dictionary = convertToDictionary(text: backToString!)
                
                if(dictionary != nil) {
                    if dictionary!["code"] as? Int64 == 414
                    {
                        showLogoutError()
                        //Handle logout and then return nil
                        
                        return nil
                    }else{
                        showSomethingWrongError()
                        return nil
                    }
                }else{
                    
                    let array = convertToArray(text: backToString!)
                    if(array != nil) {
                        do {
                            let obj = try JSONDecoder().decode(T.self, from: data!)
                            return obj
                        }catch let jsonError {
                            print("Failed to decode json: ", jsonError)
                            return nil
                        }
                    }else{
                        showSomethingWrongError()
                        return nil
                    }
                }
                
                
                
            default: //Other API error
                showSomethingWrongError()
                return nil
            }
        }
        
        return nil
    }
    
    fileprivate func showSomethingWrongError() {
        
//            FBMessageView().showMessage(message: CommonMessages.SOMETHING_WRONG, shouldAutoRemove: true)
            
    }
    
    fileprivate func showLogoutError() {
        
//        FBUtility.logoutUser()
        
//            FBUtility.showAlert(title: appName, withMessage: CommonMessages.LOGOUT)
            
    }
    
    
    fileprivate func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    fileprivate func convertToArray(text: String) -> [Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
