//
//  ProfileCollectionHeader.swift
//  MY WTM
//
//  Created by Макс Гаравський on 13.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit


class ProfileHeader: UICollectionViewCell {
    
    lazy var imageButton = UIButton(type: .system, image: #imageLiteral(resourceName: "60 x 60-1").withRenderingMode(.alwaysOriginal), backgroundColor: .clear, cornerRadius: frame.width / 5, clipsToBounds: true)
     let changeImageButton = UIButton(type: .system, title: "Change profile picture", titleFont: .systemFont(ofSize: 16, weight: .medium), backgroundColor: .clear)
     let backButton = UIButton(type: .system, image: #imageLiteral(resourceName: "chevron-left").withRenderingMode(.alwaysOriginal), backgroundColor: .clear, cornerRadius: 0, clipsToBounds: true)
     let deleteUser = UIButton(type: .system, title: "Delete User", titleFont: .systemFont(ofSize: 18, weight: .medium), tintColor: #colorLiteral(red: 0.4146325886, green: 0.4528319836, blue: 1, alpha: 1), backgroundColor: .clear, cornerRadius: 0, clipsToBounds: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear

        addSubview(imageButton)
        addSubview(changeImageButton)
        addSubview(backButton)
        addSubview(deleteUser)
        
        
        imageButton.layer.borderWidth = 0.1
        imageButton.layer.borderColor = #colorLiteral(red: 0.01238677092, green: 0.4724661112, blue: 0.9945346713, alpha: 1)
        
        imageButton.customLayout(size: .init(width: frame.width / 2.5, height: frame.width / 2.5), yAxis: centerYAnchor, xAxis: centerXAnchor)
        changeImageButton.customLayout(top: imageButton.bottomAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), xAxis: centerXAnchor)
        backButton.customLayout(leading: leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0), yAxis: imageButton.centerYAnchor)
        deleteUser.customLayout(bottom: imageButton.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 20))
    }
    
    
    
    
   required init?(coder: NSCoder) {
        fatalError()
    }
}
