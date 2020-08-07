//
//  CustomSlider.swift
//  MY WTM
//
//  Created by Макс Гаравський on 09.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//


import UIKit

class CustomSlider: UIView {

    let containerWidth: CGFloat = 107
    let containerView: UIView = {
        let field = UIView(backgroundColor: UIColor(red: 0.412, green: 0.475, blue: 0.973, alpha: 1), cornerRadius: 20, clipsToBounds: true)
        field.customSize(size: .init(width: 150, height: 40))
        return field
    }()
    let slidingView: UIView = {
        let field = UIImageView(image: #imageLiteral(resourceName: "Arrow 1-1").withTintColor(#colorLiteral(red: 0.3826318979, green: 0.4346858859, blue: 0.8958000541, alpha: 1), renderingMode: .alwaysOriginal), cornerRadius: 35/2, clipsToBounds: true, contentMode: .center )
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = #colorLiteral(red: 0.413433671, green: 0.4725294113, blue: 0.9727485776, alpha: 1)
        field.customSize(size: .init(width: 35, height: 35))
        
        return field
    }()
    let fillerView: UIView = {
        let filler = UIView(backgroundColor: UIColor(white: 0.95, alpha: 1), cornerRadius: 20, clipsToBounds: true)
        filler.customSize(size: .init(width: 150, height: 40))
        filler.alpha = 0
        return filler
    }()
    let label = UILabel(text: "Swipe to register", font: .systemFont(ofSize: 10, weight: .light), textColor: .white)
    let label2 = UILabel(text: "Done!", font: .boldSystemFont(ofSize: 12), textColor: UIColor(red: 0.412, green: 0.475, blue: 0.973, alpha: 1) )
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        customSize(size: .init(width: 150, height: 40))
        layer.cornerRadius = 0
        clipsToBounds = true
        label2.alpha = 0
            
        addSubview(containerView)
        containerView.addSubview(label)
        fillerView.addSubview(label2)
        containerView.addSubview(fillerView)
        addSubview(slidingView)
        containerView.customLayout(trailing: trailingAnchor)
        slidingView.customLayout(leading: leadingAnchor, padding: .init(top: 0, left: 4, bottom: 0, right: 0), yAxis: centerYAnchor)
        fillerView.customLayout(trailing: slidingView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -4), yAxis: containerView.centerYAnchor)
        label.customLayout(trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20),yAxis: containerView.centerYAnchor)
        label2.customLayout(yAxis: containerView.centerYAnchor, xAxis: fillerView.centerXAnchor)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: containerView)
            var x = translation.x
            x = max(0, x)
            x = min(containerWidth, x)
            print(x)
            fillerView.alpha = x / containerWidth
        
           let transform = CGAffineTransform(translationX: x, y: 0)
            slidingView.transform = transform
            fillerView.transform = transform
            if gesture.state == .changed {
                  x = max(0, x)
                  x = min(containerWidth, x)
                  slidingView.transform = CGAffineTransform(translationX: x, y: 0)
            } else if gesture.state == .ended {
                if x != containerWidth {
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        self.slidingView.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.fillerView.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.fillerView.alpha = 0
                        self.label2.alpha = 0
                    }, completion: nil)
                } else if x == containerWidth {
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        self.label2.alpha = 1
                        
                    }, completion: nil)
                }
            }
         }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
