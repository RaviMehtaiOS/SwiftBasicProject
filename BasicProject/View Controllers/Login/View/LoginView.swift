//
//  LoginView.swift
//  BasicProject
//
//  Created by Ravi Mehta on 27/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var loginModel = LoginViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        loginModel.validateAndPostData()
    }
    
    @IBAction func emailFieldEdited(_ sender: UITextField) {
        loginModel.user.emailAddress = sender.text!
    }
    
    @IBAction func passwordFieldEdited(_ sender: UITextField) {
        loginModel.user.password = sender.text!
    }
    
}
