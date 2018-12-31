//
//  BaseViewController.swift
//  BasicProject
//
//  Created by Ravi Mehta on 07/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
            INTERNET AVAILABLE
         */
        NetworkManager.sharedInstance.reachability.whenReachable = { _ in
            if(topViewController.isKind(of: NoInternetController.self)) {
                topViewController.dismiss(animated: true, completion: nil)
            }
        }
        
        
        
        /*
            NO INTERNET AVAILABLE
        */
        NetworkManager.sharedInstance.reachability.whenUnreachable = { _ in
            //Show NoInternetController
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let noInternetController = mainStoryboard.instantiateViewController(withIdentifier: "NoInternetController") as! NoInternetController
            topViewController.navigationController?.present(noInternetController, animated: true, completion: nil)
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topViewController = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
