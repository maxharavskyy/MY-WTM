//
//  MainScreenController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 06.08.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class MainScreenController: UIViewController {
    
    let avatars: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "Avatars")
        return view
    }()
    
    let backgroundLayer: UIImageView = {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "Vector-11")
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    let invitationLabel = UILabel(text: "Let's get started!", font: .systemFont(ofSize: 36), textColor: .black, numberOfLines: 1)
    let label = UILabel(text: "Signing up or log in to see\nour top events.", font: .systemFont(ofSize: 16, weight: .light), textColor: .black, numberOfLines: 2)
    let questionlabel = UILabel(text: "Don't have an account?", font: .systemFont(ofSize: 16), textColor: .black, numberOfLines: 1)
    let signButton = UIButton(type: .system, title: "Sign up", titleColor: #colorLiteral(red: 0.2531463802, green: 0.4746875167, blue: 0.924003005, alpha: 1), backgroundColor: .clear, height: 21)
    let googleButton = UIButton(type: .system, image: #imageLiteral(resourceName: "GoogleButton").withRenderingMode(.alwaysOriginal), clipsToBounds: true)
    let emailButton = UIButton(type: .system, image: #imageLiteral(resourceName: "emailButton").withRenderingMode(.alwaysOriginal), clipsToBounds: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(avatars)
        view.insertSubview(backgroundLayer, at: 0)
//        view.addSubview(invitationLabel)
//        view.addSubview(label)
//        view.addSubview(googleButton)
//        view.addSubview(emailButton)
        
        googleButton.backgroundColor = .red
        emailButton.backgroundColor = .red
        avatars.customLayout(top: view.topAnchor, padding: .init(top: 54, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 271),xAxis: view.centerXAnchor)
        
        let labelStack = VerticalStackView(arrangedSubviews: [invitationLabel, label], spacing: 16)
                
        let buttonStack = VerticalStackView(arrangedSubviews: [googleButton, emailButton], spacing: 24)
        googleButton.customLayout(size: .init(width: view.frame.width, height: 80))
        emailButton.customLayout(size: .init(width: view.frame.width, height: 80))
        
       // view.addSubview(labelStack)
       // view.addSubview(buttonStack)
       // labelStack.customLayout(top: avatars.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 54, left: 16, bottom: 0, right: 16))
       // buttonStack.customLayout(top: labelStack.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 40, left: 16, bottom: 0, right: 16))
        
        let overallStack = VerticalStackView(arrangedSubviews: [labelStack, buttonStack], spacing: 40)
        view.addSubview(overallStack)
        overallStack.customLayout(top: avatars.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 54, left: 16, bottom: 0, right: 16))
    }
    
    
}
