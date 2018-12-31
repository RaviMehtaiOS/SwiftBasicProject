//
//  NetworkModel.swift
//  BasicProject
//
//  Created by Ravi Mehta on 27/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import Foundation

struct NetworkModel {
    var params: [String: Any]?
    var url: String = ""
    var showHUD: Bool = true
    var loaderString: String = ""
    var shouldPassHeader: Bool = false
    var method: String = ""
    var arrMedia: [MediaInternalModel]?
}
