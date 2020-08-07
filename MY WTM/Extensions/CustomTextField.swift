//
//  CustomTextField.swift
//  MY WTM
//
//  Created by Макс Гаравський on 30.07.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    let padding: CGFloat
    init(padding: CGFloat, placeholder: String, backgroundColor: UIColor, keyboardType: UIKeyboardType, secureText: Bool) {
        self.padding = padding
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.layer.cornerRadius = 5
        self.backgroundColor = backgroundColor
        self.keyboardType = keyboardType
        self.isSecureTextEntry = secureText
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: padding, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: padding, dy: 0)
    }
    override var intrinsicContentSize: CGSize {
        return.init(width: 0, height: 50)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
