//
//  Temporarycell.swift
//  MY WTM
//
//  Created by Макс Гаравський on 29.07.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    let cellController = FeedCellController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        addSubview(cellController.view)
        cellController.view.customLayout(top: topAnchor, leading: leadingAnchor
            , bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 6, right: 5))
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

