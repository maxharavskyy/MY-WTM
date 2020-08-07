//
//  RegistrationController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 20.05.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD




class RegistrationController: UIViewController {
    
    var delegate: LoginControllerDelegate?
    
    let nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let emailLabel = UILabel(text: "Email Address", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let passwordLabel = UILabel(text: "Password", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let passwordLabel2 = UILabel(text: "Repeat password", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let nameField = CustomTextField(padding: 16, placeholder: "Name", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let emailField = CustomTextField(padding: 16, placeholder: "Email", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let passwordField = CustomTextField(padding: 16, placeholder: "Password", backgroundColor: .white, keyboardType: .default, secureText: true)
    let passwordField2 = CustomTextField(padding: 16, placeholder: "Password", backgroundColor: .white, keyboardType: .default, secureText: true)
    let createButton = UIButton(type: .system, title: "Create account", titleColor: .lightGray, backgroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cornerRadius: 5, height: 50)
    
    lazy var stack = VerticalStackView(arrangedSubviews: [ nameLabel, nameField, emailLabel, emailField, passwordLabel, passwordField, passwordLabel2, passwordField2, createButton], spacing: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(CAGradientLayer(colors: [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor, #colorLiteral(red: 0.44051826, green: 0.4975569844, blue: 0.9758897424, alpha: 1).cgColor], locations: [0,1], in: view.frame))
        setupKeyboardObserver()
        emailField.autocapitalizationType = .none
        createButton.isEnabled = false
        nameField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        emailField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        passwordField2.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        createButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmissKeyboard)))
        
        view.addSubview(stack)
        stack.customLayout(leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 25, bottom: 50, right: 25), yAxis: view.centerYAnchor)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self) //preventing retain cycle
    }
    
    //MARK:- obj-c action-target methods
    
    @objc func handleRegistration() {
        handleDissmissKeyboard()
        handleTextChange()
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        guard let username = nameField.text else {return}
        Api.signUp(username: username, email: email, password: password, onSuccess: {
            let confirmation = ConfirmationController()
            confirmation.modalPresentationStyle = .fullScreen
            self.navigationController?.present(confirmation, animated: true)
        }) { (errorMessage) in
            self.hud(text: errorMessage)
        }
    }
          
    @objc func handleTextChange() {
        let isValid = !nameField.text!.isEmpty && !emailField.text!.isEmpty && !passwordField.text!.isEmpty && !passwordField2.text!.isEmpty && passwordField.text?.count == passwordField2.text?.count
        if isValid {
            createButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            createButton.setTitleColor(.white, for: .normal)
            createButton.isEnabled = true
        } else {
            createButton.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            createButton.setTitleColor(.lightGray, for: .normal)
        }
    }
    
  
    
   
    
    //MARK:- Keyboard handling
    fileprivate func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc fileprivate func handleKeyboardShow(notitfication: Notification) {
        guard let value = notitfication.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - stack.frame.origin.y - stack.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 10)
    }
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    @objc fileprivate func handleDissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK:- UI
    func hud(text : String, indicatorView: JGProgressHUDIndicatorView = JGProgressHUDErrorIndicatorView()) {
          let progressHUD = JGProgressHUD(style: .dark)
          progressHUD.textLabel.text = text
          progressHUD.show(in: self.view )
          progressHUD.dismiss(afterDelay: 1.8)
      }
   
}

