//
//  BaseMessageView.swift
//  BasicProject
//
//  Created by Ravi Mehta on 24/08/18.
//  Copyright © 2018 Ravi Mehta. All rights reserved.
//

import UIKit

class BaseMessageView: UIView {
    
    // MARK: - UI Elements
    
    var backgroundView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .black
        bgView.alpha = 0.55
        return bgView
    }()

    var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var okButton: UIButton = {
        let okBtn = UIButton()
        okBtn.backgroundColor = UIColor.darkGray
        okBtn.setTitle("Ok", for: .normal)
        okBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        okBtn.translatesAutoresizingMaskIntoConstraints = false
        return okBtn
    }()
    
    
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Deinit")
    }
    
    func setupView() {
        self.backgroundColor = UIColor(named: "Theme")
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.alpha = 0.0
    }
    
    func showMessage(message: String, shouldAutoRemove: Bool) {
        
        //Fetching the app window
        if let window = UIApplication.shared.keyWindow {
            
            //Adding subviews
            window.addSubview(self.backgroundView)
            
            //BackgroundView
            self.backgroundView.frame = CGRect(x: 0.0, y: 0.0, width: window.frame.width, height: window.frame.height)
            
            
            
            self.addSubview(self.messageLabel)
            self.addSubview(self.okButton)
            
            //Assigning text to message label
            self.messageLabel.text = message
            
            

            self.okButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive=true
            self.okButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            self.okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            self.okButton.heightAnchor.constraint(equalToConstant: 60)
            
            //Message label constraints
            self.messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive=true
            self.messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            self.messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            self.messageLabel.bottomAnchor.constraint(equalTo: self.okButton.topAnchor, constant: 0).isActive = true
            
            
            
            
            
            //Calculating string height
            let height = message.height(withConstrainedWidth: window.frame.width - 30, font: self.messageLabel.font)
            print(height)
            
            //Setting the frame of the view above the window bounds so that it can be animated later
            self.frame = CGRect(x: 15, y: window.frame.height + 50, width: window.frame.width - 30, height: 30 + height + 60)
   
            window.addSubview(self)
            
            //Animating the frame with bounce
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: [.curveEaseIn, .allowUserInteraction], animations: {

                self.center = window.center
                self.alpha = 1.0
                
            }, completion: { (complete) in
                self.removeFromSuperview()
                self.backgroundView.removeFromSuperview()
            })
            
        }
        
    }
    
    
}
