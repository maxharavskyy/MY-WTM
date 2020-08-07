//
//  TemporaryController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 30.07.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class FeedCellController: UIViewController {
    
    var event: Event? {
        didSet {
            titleLabel.text = event?.title
            dateLabel.text = event?.date
            imageView.sd_setImage(with: URL(string: event?.imageUrl ?? ""))
        }
    }
    
    let categoryLabel = UILabel(font: .boldSystemFont(ofSize: 16))
    
    let titleLabel =  UILabel(font: .systemFont(ofSize: 16, weight: .medium))
    
    let dateLabel = UILabel(font: .systemFont(ofSize: 19), textColor: .init(white: 0.5, alpha: 0.95))

    let visitorsLabel = UILabel(text: "are going", font: .systemFont(ofSize: 10), textColor: .init(white: 0.5, alpha: 0.95))
    
    let bookmarkButton = UIButton(type: .system, image: #imageLiteral(resourceName: "Vector-3").withRenderingMode(.alwaysOriginal), backgroundColor: .clear, cornerRadius: 0, clipsToBounds: true)
    
    let registrationButton = UIButton(type: .system, title: "Register", titleColor: .white, backgroundColor: #colorLiteral(red: 0.413433671, green: 0.4725294113, blue: 0.9727485776, alpha: 1), cornerRadius: 10, height: 40)

    var imageView: UIImageView = {
           let imageView = UIImageView()
           imageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           imageView.layer.borderWidth = 1
           imageView.contentMode = .scaleAspectFill
           imageView.layer.cornerRadius = 8
           imageView.clipsToBounds = true
           return imageView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imageView.customSize(size: .init(width: view.frame.width - 25, height: 180))
        bookmarkButton.customSize(size: .init(width: 20, height: 25))
        registrationButton.customSize(size: .init(width: 150, height: 40))
        
        registrationButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
        let bottomStack = StackView(arrangedSubviews: [visitorsLabel, UIView(), registrationButton], spacing: 4)
        let overallStack = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel, bookmarkButton]), dateLabel, imageView, bottomStack ], spacing: 10)
        view.addSubview(overallStack)
        overallStack.fillSuperview()
    }
    
    @objc func handleRegistration() {
        let popController = EventRegistrationController()
        popController.textField.text = User.shared.email
        popController.textField2.text = User.shared.fullname
        popController.eventRegistrationHandler = {
            self.dismiss(animated: true) {
                let user = User.shared
                self.event?.registerForEvent(user: user, onError: { (err) in
                    print(err.localizedDescription)
                    return
                }) {
                    print("Success")
                }
            }
        }
        present(popController, animated: true, completion: nil)
    }
    
}

