//
//  Post.swift
//  BasicProject
//
//  Created by Ravi Mehta on 28/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit

class Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
