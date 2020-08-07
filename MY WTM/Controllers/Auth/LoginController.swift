//
//  LoginController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 20.05.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//



import UIKit
import Firebase
import JGProgressHUD
import GoogleSignIn



protocol LoginControllerDelegate {
    func didFinishLoggingIn()
}

class LoginController: UIViewController, GIDSignInDelegate {
    
    var delegate: LoginControllerDelegate? 
    
    let label = UILabel(text: "Welcome!", font: .systemFont(ofSize: 32, weight: .medium), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let emailLabel = UILabel(text: "Email Address", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let passwordLabel = UILabel(text: "Password", font: .systemFont(ofSize: 16, weight: .light), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
   
    let emailField = CustomTextField(padding: 16, placeholder: "enter email", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let passwordField = CustomTextField(padding: 16, placeholder: "enter password", backgroundColor: .white, keyboardType: .default, secureText: true)
    
    let startButton = UIButton(type: .system, title: "Get Started", titleColor: .white, backgroundColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), cornerRadius: 5, height: 50)
    let forgetButton = UIButton(type: .system, title: "forget password?", titleColor: .white, backgroundColor: UIColor(white: 0, alpha: 0), cornerRadius: 5, height: 50)
    let createButton = UIButton(type: .system, title: "Create new account!", titleFont: .systemFont(ofSize: 16, weight: .light), tintColor: .white, backgroundColor: .clear, cornerRadius: 0, clipsToBounds: true)
    
    let googleButton: UIButton = {
        let googleButton = UIButton(type: .system, image: #imageLiteral(resourceName: "Vector-10"), title: "Continue with Google", titleFont: .systemFont(ofSize: 18, weight: .light), tintColor: .white, backgroundColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), cornerRadius: 5, clipsToBounds: true)
        let separator = UIView(backgroundColor: .white, cornerRadius: 0)
        googleButton.addSubview(separator)
        separator.customLayout(leading: googleButton.imageView?.trailingAnchor, padding: .init(top: 0, left: (googleButton.imageView?.frame.width)! / 1.5, bottom: 0, right: 0), size: .init(width: 0.3, height: 30), yAxis: googleButton.centerYAnchor)
        googleButton.imageView?.customLayout(leading: googleButton.leadingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 0),size: .init(width: googleButton.frame.height, height: googleButton.frame.height), yAxis: googleButton.centerYAnchor)
        googleButton.customSize(size: .init(width: .zero, height: 50))
        return googleButton
    }()
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.layer.addSublayer(CAGradientLayer(colors: [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor, #colorLiteral(red: 0.44051826, green: 0.4975569844, blue: 0.9758897424, alpha: 1).cgColor], locations: [0,1], in: view.frame))
        setupTransparentBar()
        emailField.autocapitalizationType = .none
        
        let stack = VerticalStackView(arrangedSubviews: [emailLabel, emailField, passwordLabel, passwordField, startButton, UIStackView(arrangedSubviews: [UIView(), forgetButton]), UIView(), googleButton, createButton], spacing: 16)
        
        view.addSubview(label)
        view.addSubview(stack)

       label.customLayout(top: view.topAnchor, leading: view.leadingAnchor, padding: .init(top: 95, left: 30, bottom: 0, right: 0))
        stack.customLayout(top: view.topAnchor,leading: view.leadingAnchor,bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: view.frame.height / 4, left: 30, bottom: 30, right: 30),yAxis: view.centerYAnchor)
        
        startButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        createButton.addTarget(self, action: #selector (handleCreation), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleHandle), for: .touchUpInside)
        forgetButton.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmissKeyboard)))
    }
   
    
    //MARK:- Google signIn method
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.hud(text: error.localizedDescription)
            return
        }
        guard let auth = user.authentication else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Api.googleSignIn(credentials: credentials, onSuccess: {
            self.dismiss(animated: true) {
                self.delegate?.didFinishLoggingIn()
            }
        }) { (errorMessage) in
             self.hud(text: errorMessage)
            return
        }
    }
    
    //MARK:- obj-c target-action methods
   @objc func handleLogin() {
       guard let email = emailField.text, email.isEmpty == false else {return}
       guard let password = passwordField.text, password.isEmpty == false else {return}
    
        Api.signIn(email: email, password: password, onSuccess: {
           self.dismiss(animated: true) {
               self.delegate?.didFinishLoggingIn()
           }
       }) { (errorMessage) in
           self.hud(text: errorMessage)
       }
    }
    
    @objc func handleForgetPassword() {
        let forgetPasswordController = ResetPasswordController()
        present(forgetPasswordController, animated: true)
        forgetPasswordController.handler = {
            self.hud(text: "We've recently sent you an email with instructions. Please check your inbox", indicatorView: JGProgressHUDSuccessIndicatorView())
        }
    }
    
    @objc func handleCreation() {
        let creationController = RegistrationController()
        creationController.delegate = delegate
        navigationController?.pushViewController(creationController, animated: true)
    }
    
    @objc func googleHandle() {
       GIDSignIn.sharedInstance().presentingViewController = self
       GIDSignIn.sharedInstance().delegate = self
       GIDSignIn.sharedInstance().signIn()
    }
    
    @objc fileprivate func handleDissmissKeyboard() {
        self.view.endEditing(true)
    }
   
    
    
    //MARK:- UI set up
    func hud(text : String, indicatorView: JGProgressHUDIndicatorView = JGProgressHUDErrorIndicatorView()) {
        let progressHUD = JGProgressHUD(style: .dark)
        progressHUD.textLabel.text = text
        progressHUD.show(in: self.view )
        progressHUD.dismiss(afterDelay: 1.8)
    }
    
    //convert to extension!!!
    func setupTransparentBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }

}
