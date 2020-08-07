//
//  SettingsCollectionCell.swift
//  MY WTM
//
//  Created by Макс Гаравський on 13.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class SettingsTableCell: UITableViewCell {
    
    let imageVi = UIImageView(image: #imageLiteral(resourceName: "Vector-7").withTintColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), renderingMode: .alwaysOriginal), cornerRadius: 20, clipsToBounds: true, contentMode: .center)
    let label = UILabel(text: "Email", font: .systemFont(ofSize: 16, weight: .light), textColor: .black, numberOfLines: 1)
    let descLabel = UILabel(text: "Change Email", font: .systemFont(ofSize: 13, weight: .light), textColor: .init(white: 0.5, alpha: 1), numberOfLines: 1)
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageVi.backgroundColor = #colorLiteral(red: 0.8716471791, green: 0.9696685672, blue: 0.8793500662, alpha: 1)
        addSubview(imageVi)
        addSubview(label)
        addSubview(descLabel)
        imageVi.customLayout(leading: leadingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0),size: .init(width: 40, height: 40), yAxis: centerYAnchor)
        label.customLayout(leading: imageVi.trailingAnchor, bottom: centerYAnchor, padding: .init(top: 0, left: 20, bottom: 2, right: 0))
        descLabel.customLayout(top: centerYAnchor,leading: imageVi.trailingAnchor, padding: .init(top: 2, left: 20, bottom: 0, right: 0))
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
