//
//  ValidationManager.swift
//  BasicProject
//
//  Created by Ravi Mehta on 23/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation

class ValidationManager {
    static let sharedInstance = ValidationManager()
    private init(){}
    
    func validateLoginUser(user: User) throws {
        //Email Address
        if(user.emailAddress.isEmpty) {
            throw AuthenticationError.EmptyEmail
        }
        if(ValidationUtil.isValidEmailAddress(user.emailAddress) == false) {
            throw AuthenticationError.InvalidEmail
        }
        
        //Password
        if(user.password.isEmpty) {
            throw AuthenticationError.EmptyPassword
        }
        if(user.password.count < Constants.PASSWORD_LIMIT) {
            throw AuthenticationError.PasswordLimit
        }
    }
}



