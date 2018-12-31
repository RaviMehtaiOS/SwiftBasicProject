//
//  FBMediaInternalModel.swift
//  FamilyBook
//
//  Created by Ravi Mehta on 27/11/17.
//  Copyright © 2017 Ravi Mehta. All rights reserved.
//
import UIKit

struct MediaInternalModel {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    

    
    init?(withImage image: UIImage, forKey key: String, withFileName filename: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.filename = filename//"file.jpg"
        guard let data = UIImageJPEGRepresentation(image, 0.9) else { return nil }
        self.data = data
    }
    
    init?(withVideoData data: Data, forKey key: String, withFileName filename: String) {
        self.key = key
        self.mimeType = "Video/mov"
        self.filename = filename//"video.mov"
        self.data = data
    }
    
}
