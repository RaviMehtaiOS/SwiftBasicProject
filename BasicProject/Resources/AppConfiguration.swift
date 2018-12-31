//
//  AppConfiguration.swift
//  BasicProject
//
//  Created by Ravi Mehta on 23/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation

struct Constants {
    
    // MARK: - CONSTANT VALUES
    static let PASSWORD_LIMIT: Int8 = 8
    
    // MARK: - View Controller Identifiers
    struct VCIdentifier {
        static let LoginVC = "LoginController"
        static let NoInternetVC = "NoInternetController"
        static let RegisterVC = "RegistrationController"
    }
    
    // MARK: - Storyboard Identifiers
    struct StoryboardIdentifier {
        static let Main = "Main"
    }
    
    // MARK: - Character Sets
    struct AppCharacterSet {
        static let OnlyAlphabetsWithOutSpace = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"
        static let AlphabetsAndASpace = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ "
        static let OnlyNumbers = "1234567890"
        static let NumbersWithDecimalPoint = "1234567890."
    }
    
    // MARK: - Time Out Interval
    struct TimeOutInterval {
        public static var SMALL: TimeInterval = 5.0
        public static var MEDIUM: TimeInterval = 10.0
        public static var LARGE: TimeInterval = 20.0
    }
    
    // MARK: - HTTP Methods
    struct HTTPMethod {
        public static var GET: String = "GET"
        public static var POST: String = "POST"
        public static var DELETE: String = "DELETE"
    }
    
}




