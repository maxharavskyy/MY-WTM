//
//  ConfirmationController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 20.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class ConfirmationController: UIViewController {
    
    var delegate: LoginControllerDelegate?

    let errorHUD = JGProgressHUD(style: .dark, indicatorView: JGProgressHUDErrorIndicatorView())
    let label = UILabel(text: "Please confirm your email", font: .systemFont(ofSize: 20, weight: .medium), textColor: .white, numberOfLines: 2)
    let appButton = UIButton(type: .system, title:  "Go to app", titleFont: .systemFont(ofSize: 20, weight: .medium), tintColor: .white, backgroundColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),  cornerRadius: 5, clipsToBounds: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.layer.addSublayer(CAGradientLayer(colors: [#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor, #colorLiteral(red: 0.44051826, green: 0.4975569844, blue: 0.9758897424, alpha: 1).cgColor], locations: [0,1], in: view.frame))
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(appButton)
        label.centerInSuperview()
        appButton.customLayout(top: label.bottomAnchor,padding: .init(top: 25, left: 0, bottom: 0, right: 0),size: .init(width: 150, height: 50), xAxis: label.centerXAnchor)
        appButton.addTarget(self, action: #selector(handleGoToApp), for: .touchUpInside)
    }
   
    @objc func handleGoToApp() {
        guard  let user = Auth.auth().currentUser else {return}
        user.reload { (err) in
            if user.isEmailVerified == true {
                self.dismiss(animated: true, completion: {
                    self.delegate?.didFinishLoggingIn()
                })
            } else {
                self.errorHUD.textLabel.text = "please verify your email"
                self.errorHUD.show(in: self.view)
                self.errorHUD.dismiss(afterDelay: 2, animated: true)
                return
            }
        }
    }

}
