//
//  LoginViewModel.swift
//  BasicProject
//
//  Created by Ravi Mehta on 07/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class LoginViewModel: NSObject {
    var user = User()

    
    func validateAndPostData() {
        let success = AuthenticationManager.sharedInstance.validateLoginUser(user: user)
        if(success == true) {
            
            
            
            
            // Create destination URL
            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
            let destinationFileUrl = documentsUrl.appendingPathComponent((URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")?.lastPathComponent)!)
    
            
            if(FileManager.default.fileExists(atPath: destinationFileUrl.path)) {
                let playerViewController = AVPlayerViewController()
                playerViewController.entersFullScreenWhenPlaybackBegins = true
                playerViewController.exitsFullScreenWhenPlaybackEnds = true
                topViewController.present(playerViewController, animated: true, completion: nil)
                let player = AVPlayer(url: destinationFileUrl)
                playerViewController.player = player
                player.play()
            }else{
                let networkObj = NetworkModel(params: nil, url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", showHUD: true, loaderString: "", shouldPassHeader: true, method: "", arrMedia: [])
                NetworkManager.sharedInstance.downloadDataFromServer(networkObj: networkObj)
            }

        }else{

        }
    }
    
}
