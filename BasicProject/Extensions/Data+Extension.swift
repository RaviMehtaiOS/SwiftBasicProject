//
//  Data+Extension.swift
//  BasicProject
//
//  Created by Ravi Mehta on 28/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
