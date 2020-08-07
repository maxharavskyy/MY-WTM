//
//  RegistrationController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 25.07.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class EventRegistrationController: UIViewController {
    
    var eventRegistrationHandler: (() -> ())?
     
    let label = UILabel(text: "Register for event", font: .systemFont(ofSize: 16, weight: .semibold), numberOfLines: 1)
    let label1 = UILabel(text: "Your email", font: .systemFont(ofSize: 16, weight: .medium), numberOfLines: 1)
    let textField = CustomTextField(padding: 10, placeholder: "Email@email.com", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let label2 = UILabel(text: "How we will recognize you?", font: .systemFont(ofSize: 16, weight: .medium), numberOfLines: 1)
    let textField2 = CustomTextField(padding: 10, placeholder: "enter here", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let registerButton = UIButton(type: .system, title: "Register", titleColor: .white, backgroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cornerRadius: 5, height: 50)
    lazy var stack = VerticalStackView(arrangedSubviews: [label1, textField, label2, textField2, registerButton], spacing: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9616693854, green: 0.9565404058, blue: 0.9652972817, alpha: 1)
        view.addSubview(label)
        label.customLayout(top: view.topAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0),xAxis: view.centerXAnchor)
        
        let stack = VerticalStackView(arrangedSubviews: [label1, textField, label2, textField2, registerButton], spacing: 20)
          
        view.addSubview(stack)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmissKeyboard)))
        stack.customLayout(top: label.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 60, left: 25, bottom: 0, right: 25))
            registerButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
    }
    
    @objc func handleRegistration() {
        eventRegistrationHandler?()
    }
          
    @objc fileprivate func handleDissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    
}

    

