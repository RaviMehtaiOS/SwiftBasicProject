//
//  ValidationUtil.swift
//  BasicProject
//
//  Created by Ravi Mehta on 23/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation


class ValidationUtil {
    class func isValidEmailAddress(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    class func isValidTextFor(string stringValue: String, appCharacterSet characterSet: String) -> Bool{
        let characterset = CharacterSet(charactersIn: characterSet)
        if (stringValue.rangeOfCharacter(from: characterset.inverted) != nil) {
            return false
        }else {
            return true
        }
    }
}
