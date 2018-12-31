//
//  NetworkManager.swift
//  BasicProject
//
//  Created by Ravi Mehta on 07/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation
import Reachability
import AVKit
import AVFoundation

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    var reachability: Reachability!
    
    typealias RequestResult = (Data?, URLResponse?, Error?) -> ()
    var dataTask: URLSessionDataTask?



    private override init(){
        super.init()
        reachability = Reachability()!
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .none {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .none {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    
    
    
    func isNetworkAvailable() -> Bool {
        if(reachability.connection == .none) {
            return false
        }else{
            return true
        }
    }
    
    
    // MARK: - GET DataTask
    func getDataFromServer(networkObj: NetworkModel, completion: @escaping RequestResult) {
        
        //Creating a URL String
        var urlString = networkObj.url
        if let params = networkObj.params {
            for (key, value) in params {
                if(urlString.contains("?")) {
                    urlString = urlString + "&\(key)=\(value)"
                }else{
                    urlString = urlString + "?\(key)=\(value)"
                }
            }
        }
        
        //Creating a URL Object
        let url = URL(string: urlString)
        
        //Validating the URL Object
        guard let validUrl = url else { return }
        
        //Creating a request
        let request = createRequest(forUrl: validUrl, forMethod: Constants.HTTPMethod.GET)
        
        //Fetching data from Server
        let defaultSession = URLSession(configuration: .default)
        dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        dataTask?.resume()
    }
    
    // MARK: - DELETE DataTask
    func deleteDataFromServer(networkObj: NetworkModel, completion: @escaping RequestResult) {
        
        //Creating a URL String
        var urlString = networkObj.url
        if let params = networkObj.params {
            for (key, value) in params {
                if(urlString.contains("?")) {
                    urlString = urlString + "&\(key)=\(value)"
                }else{
                    urlString = urlString + "?\(key)=\(value)"
                }
            }
        }
        
        //Creating a URL Object
        let url = URL(string: urlString)
        
        //Validating the URL Object
        guard let validUrl = url else { return }
        
        //Creating a request
        let request = createRequest(forUrl: validUrl, forMethod: Constants.HTTPMethod.DELETE)
        
        //Delete data from Server
        let defaultSession = URLSession(configuration: .default)
        dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        dataTask?.resume()
    }
    
    // MARK: - Download DataTask
    func downloadDataFromServer(networkObj: NetworkModel) {
        
        //Creating a URL String
        let urlString = networkObj.url
        
        //Creating a URL Object
        let url = URL(string: urlString)
        
        //Validating the URL Object
        guard let validUrl = url else { return }
        
        //Creating a Request Object
        var request = URLRequest(url: validUrl)
        request.allowsCellularAccess = true
        request.timeoutInterval = Constants.TimeOutInterval.MEDIUM
        
        let downloadSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        
        let downloadTask = downloadSession.downloadTask(with: request)
        
        downloadTask.resume()
    }
    
    
    
    
    // MARK: - POST DataTask

    func postDataToServer(networkObj: NetworkModel, completion: @escaping RequestResult) {
        
        let url = URL(string: networkObj.url)
        
        guard let validUrl = url else { return }
        
        let boundary = generateBoundaryString()
        
        //Creating a request
        var request = createRequest(forUrl: validUrl, forMethod: Constants.HTTPMethod.POST)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //Appending in the header
        if(networkObj.shouldPassHeader)
        {
//            request?.setValue(PersistenceManager.sharedInstance.getUserObject()?.access_token!, forHTTPHeaderField: "access_token")
        }
        
        //Creating the params body
        let dataBody = createDataBody(withNetworkObj: networkObj, boundary: boundary)
        request.httpBody = dataBody

        //Post data to Server
        let defaultSession = URLSession(configuration: .default)
        dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        dataTask?.resume()
    }
    
    
    // MARK: - Request helpers
    func createRequest(forUrl: URL, forMethod: String) -> URLRequest {
        var request = URLRequest(url: forUrl)
        request.allowsCellularAccess = true
        request.httpMethod = forMethod
        request.timeoutInterval = Constants.TimeOutInterval.SMALL
        return request
    }
    
    
    
    func createDataBody(withNetworkObj networkObj: NetworkModel, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        //Appending parameters
        if let parameters = networkObj.params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value as! String + lineBreak)")
            }
        }
        
        //Appending media
        if let media = networkObj.arrMedia {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}

extension NetworkManager: URLSessionDownloadDelegate, URLSessionDelegate {
    //Download Finish
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(location.absoluteString)
        print(downloadTask.originalRequest?.url?.absoluteString ?? "")
        
        
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent((downloadTask.originalRequest?.url?.lastPathComponent)!)
        
        
        //Removing a previously downloaded file
        do {
            try FileManager.default.removeItem(at: destinationFileUrl)
        }catch (let removeError) {
            print("Error removing file: \(removeError)")
        }
        
        //Copying the file from temp location to Documents Directory
        do {
            try FileManager.default.copyItem(at: location, to: destinationFileUrl)
        } catch (let writeError) {
            print("Error creating a file: \(destinationFileUrl) : \(writeError)")
        }
        
        //Playing the downloaded file
        let playerViewController = AVPlayerViewController()
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        playerViewController.exitsFullScreenWhenPlaybackEnds = true
        topViewController.present(playerViewController, animated: true, completion: nil)
        let player = AVPlayer(url: destinationFileUrl)
        playerViewController.player = player
        player.play()
        
    }
    
    //Download
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if let lastPathComponent = downloadTask.originalRequest?.url?.lastPathComponent {
            print(String(format: "\(lastPathComponent) Downloading: %.1f%%", (Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)) * 100))
        }
    }
    
    //Upload
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        if let lastPathComponent = task.originalRequest?.url?.lastPathComponent {
            print(String(format: "\(lastPathComponent) Uploading: %.1f%%", (Float(totalBytesSent)/Float(totalBytesExpectedToSend)) * 100))
        }
    }
    
    //Error
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Error")
    }
}
