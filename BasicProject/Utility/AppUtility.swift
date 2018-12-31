//
//  AppUtility.swift
//  BasicProject
//
//  Created by Ravi Mehta on 23/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit

class AppUtility {
    class func showAlert(title: String = "Basic Project", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        topViewController.present(alertController, animated: true, completion: nil)
    }
}
