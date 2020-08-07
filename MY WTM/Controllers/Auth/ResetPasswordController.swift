//
//  ResetPasswordController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 24.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase

class ResetPasswordController: UIViewController {
    
   let emailField = CustomTextField(padding: 16, placeholder: "enter email", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let resetPasswordButton = UIButton(type: .system, title: "Reset my password", titleColor: .white, backgroundColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), cornerRadius: 5, height: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.layer.addSublayer(CAGradientLayer(colors: [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor, #colorLiteral(red: 0.44051826, green: 0.4975569844, blue: 0.9758897424, alpha: 1).cgColor], locations: [0,1], in: view.frame))
        setupTapGesture()
        emailField.autocapitalizationType = .none
        
        let stack = VerticalStackView(arrangedSubviews: [emailField, resetPasswordButton], spacing: 30)
        view.addSubview(stack)
        stack.customLayout(top: view.topAnchor,leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 30, bottom: 0, right: 30))
        resetPasswordButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        
    }
    
    var handler: (() -> ())?
    
    @objc func handleReset() {
        guard let email = emailField.text, !email.isEmpty else {
            self.hud(text: "Please provide your email", indicatorView: JGProgressHUDSuccessIndicatorView())
            return
        }
        Api.passwordReset(email: email, onSuccess: {
            self.hud(text: "Please check your inbox", indicatorView: JGProgressHUDSuccessIndicatorView())
            self.dismiss(animated: true) {
                self.handler?()
            }
        }) { (error) in
            if  error == error {
                self.hud(text: error)
            }
        }
    }
    
    func hud(text : String, indicatorView: JGProgressHUDIndicatorView = JGProgressHUDErrorIndicatorView()) {
        let progressHUD = JGProgressHUD(style: .dark)
        progressHUD.textLabel.text = text
        progressHUD.show(in: self.view )
        progressHUD.dismiss(afterDelay: 1.8)
    }
    
    fileprivate func setupTapGesture() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmissKeyboard)))
    }
    @objc fileprivate func handleDissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    
}
