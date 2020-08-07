//
//  Extensions.swift
//  MY WTM
//
//  Created by Макс Гаравський on 20.05.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//


import UIKit
import JGProgressHUD

extension UILabel {
    convenience init(text: String? = "", font: UIFont, textColor: UIColor? = nil, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


extension CAGradientLayer {
    convenience init(colors: [CGColor], locations: [NSNumber], in frame: CGRect) {
        self.init()
        self.colors = colors
        self.locations = locations
        self.frame = frame
    }
}

extension UIButton {
    convenience init(type: ButtonType, title: String, titleColor: UIColor, backgroundColor: UIColor, cornerRadius: CGFloat = 0, height: CGFloat) {
        self.init(type: type)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.backgroundColor = backgroundColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.heightAnchor.constraint(equalToConstant: height).isActive  = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton {
    convenience init(type: ButtonType, image: UIImage? = nil, title: String = "", titleFont: UIFont? = nil,  tintColor: UIColor? = nil , backgroundColor: UIColor = .white, cornerRadius: CGFloat = 0, clipsToBounds: Bool = false) {
    self.init(type: type)
    self.setImage(image, for: .normal)
    self.setTitle(title, for: .normal)
    self.tintColor = tintColor
    self.titleLabel?.font = titleFont
    self.layer.backgroundColor = backgroundColor.cgColor
    self.layer.cornerRadius = cornerRadius
    self.clipsToBounds = clipsToBounds
    self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
extension UIView {
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat, clipsToBounds: Bool = false, shadowOpacity: Float = 0, shadowRadius: CGFloat = 0, shadowOffset: CGSize = .init(width: 0, height: 0)) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImageView {
    convenience init(image: UIImage, cornerRadius: CGFloat, clipsToBounds: Bool = false, contentMode: UIView.ContentMode) {
        self.init(frame: .zero)
        self.image = image
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
        self.contentMode = contentMode
    }
}

extension JGProgressHUD {
    convenience init(style: JGProgressHUDStyle, indicatorView: JGProgressHUDIndicatorView, text: String = "") {
        self.init(style: style)
        self.textLabel.text = text
        self.indicatorView = indicatorView
    }
}

