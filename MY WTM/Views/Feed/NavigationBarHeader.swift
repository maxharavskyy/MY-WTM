//
//  EventFeedHeaderCell.swift
//  MY WTM
//
//  Created by Макс Гаравський on 11.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class NavigationBarHeader: UICollectionViewCell {
    
    var openProfileHandler: (() -> ())?
    var openSearchHandler: (() -> ())?
    
    let label = UILabel(text: "Women Techmakers\nLviv", font: .systemFont(ofSize: 18, weight: .medium), numberOfLines: 0)
    let profileButt = UIButton(type: .system, image: #imageLiteral(resourceName: "60 x 60").withRenderingMode(.alwaysOriginal), backgroundColor: .clear, cornerRadius: 25, clipsToBounds: true)
    let searchButton = UIButton(type: .system, image: #imageLiteral(resourceName: "search-2").withRenderingMode(.alwaysOriginal), backgroundColor: .clear, cornerRadius: 30, clipsToBounds: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileButt.layer.borderWidth = 0.1
        profileButt.layer.borderColor = #colorLiteral(red: 0.01238677092, green: 0.4724661112, blue: 0.9945346713, alpha: 1)
        backgroundColor = .clear
        label.textAlignment = NSTextAlignment.center
        profileButt.contentMode = .scaleToFill
        addSubview(label)
        addSubview(profileButt)
        addSubview(searchButton)
        label.customLayout(bottom: bottomAnchor,xAxis: centerXAnchor)
        profileButt.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 18, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        searchButton.customLayout(bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 18), size: .init(width: 60, height: 60))
        
        profileButt.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
    }
    
    
    @objc func handleProfile() {
        openProfileHandler?()
    }
    @objc func handleSearch() {
        openSearchHandler?()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
