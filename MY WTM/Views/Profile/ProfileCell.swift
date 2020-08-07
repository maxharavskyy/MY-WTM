//
//  ProfileCollectionCell.swift
//  MY WTM
//
//  Created by Макс Гаравський on 13.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    let tableController = SettingsTableController()
    let nameLabel = UILabel(text: "", font: .systemFont(ofSize: 18, weight: .light), textColor: .init(white: 0.5, alpha: 1), numberOfLines: 1)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 50
        
        addSubview(nameLabel)
        addSubview(tableController.view)
        nameLabel.customLayout(top: topAnchor,padding: .init(top: 15, left: 0, bottom: 0, right: 0), xAxis: tableController.view.centerXAnchor)
        tableController.view.customLayout(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: frame.width, height: frame.height / 1.5))
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
