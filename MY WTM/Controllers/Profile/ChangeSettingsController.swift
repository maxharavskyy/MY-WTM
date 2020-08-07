//
//  ChangeSettingsController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 15.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase



class ChangeSettingsController: UIViewController {
    
    var userInfoHandler: ((String) -> ())?
    
    let closeButton = UIButton(type: .system, image: #imageLiteral(resourceName: "Cancel").withRenderingMode(.alwaysOriginal), backgroundColor: .clear, cornerRadius: 0, clipsToBounds: true)
    
    let label = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .semibold), numberOfLines: 1)
    let label1 = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium), numberOfLines: 1)
    let textField = CustomTextField(padding: 10, placeholder: "Email@email.com", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
    let label2 = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium), numberOfLines: 1)
    let textField2 = CustomTextField(padding: 10, placeholder: "enter here", backgroundColor: .white, keyboardType: .emailAddress, secureText: false)
     let saveButton = UIButton(type: .system, title: "Save", titleColor: .white, backgroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cornerRadius: 5, height: 50)
    lazy var stack = VerticalStackView(arrangedSubviews: [label1, textField, label2, textField2, saveButton], spacing: 20)
    
    var desc: String?
    var newInfo: String?
    var allowTextInput: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9616693854, green: 0.9565404058, blue: 0.9652972817, alpha: 1)
        
        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(closeButton)
        view.addSubview(label)
        
        textField.isEnabled = allowTextInput ?? false
        
        label.text = "Change your \(desc ?? "email")"
        label1.text = "Your current \(desc ?? "email")"
        label2.text = "Your new \(desc ?? "email")"
        
        label.customLayout(yAxis: closeButton.centerYAnchor,xAxis: view.centerXAnchor)
        closeButton.customLayout(top: view.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 25))
        let stack = VerticalStackView(arrangedSubviews: [label1, textField, label2, textField2, saveButton], spacing: 20)
        
        view.addSubview(stack)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmissKeyboard)))
        stack.customLayout(top: closeButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 60, left: 25, bottom: 0, right: 25))
        saveButton.addTarget(self, action: #selector(updateInfo), for: .touchUpInside)
        
        
    }
    
    
    @objc func updateInfo() {
        guard let info = textField2.text, info.isEmpty == false else {return}
        userInfoHandler?(info)
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
    
    @objc fileprivate func handleDissmissKeyboard() {
          self.view.endEditing(true)
    }
     
    
}
