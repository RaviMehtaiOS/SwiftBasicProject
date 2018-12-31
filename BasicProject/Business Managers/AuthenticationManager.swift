//
//  AuthenticationManager.swift
//  BasicProject
//
//  Created by Ravi Mehta on 23/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation

class AuthenticationManager {
    static let sharedInstance = AuthenticationManager()
    private init(){}
    
    func validateLoginUser(user: User) -> Bool {
        do {
            try ValidationManager.sharedInstance.validateLoginUser(user: user)
        } catch AuthenticationError.EmptyEmail {
//            AppUtility.showAlert(message: "Empty Email")
            return false
        } catch AuthenticationError.InvalidEmail {
//            AppUtility.showAlert(message: "Invalid Email")
            return false
        } catch AuthenticationError.EmptyPassword {
//            AppUtility.showAlert(message: "Empty Password")
            return false
        } catch AuthenticationError.PasswordLimit {
//            AppUtility.showAlert(message: "Password Limit")
            return false
        }catch {
//            AppUtility.showAlert(message: "Other Error")
            return false
        }

        return true
    }
    
}

enum AuthenticationError: Error {
    case EmptyEmail
    case InvalidEmail
    case EmptyPassword
    case PasswordLimit
    case PasswordUnMatch
}
