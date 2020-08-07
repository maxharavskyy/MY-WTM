//
//  EventCell.swift
//  MY WTM
//
//  Created by Макс Гаравський on 11.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit



class EventCell: UICollectionViewCell {
    
    let image = UIImageView(image: #imageLiteral(resourceName: "empty"), cornerRadius: 8, clipsToBounds: true, contentMode: .scaleAspectFill)
    let backButton = UIButton(type: .system, image: #imageLiteral(resourceName: "chevron-left").withRenderingMode(.alwaysOriginal),title: "Back",titleFont: .systemFont(ofSize: 13, weight: .light),tintColor: .black, backgroundColor: .clear, cornerRadius: 0)
    let titleLabel =  UILabel(text: "IOS Development meet-up", font: .systemFont(ofSize: 16, weight: .medium))
    let registrationButton = UIButton(type: .system, title: "Register", titleColor: .white, backgroundColor: #colorLiteral(red: 0.413433671, green: 0.4725294113, blue: 0.9727485776, alpha: 1), cornerRadius: 10, height: 40)
    
    let locationLabel = UILabel(text: "Symphony solutions ", font: .systemFont(ofSize: 15, weight: .light), textColor: .init(white: 0.5, alpha: 0.95), numberOfLines: 2)
    let mapButton = UIButton(type: .system, image: #imageLiteral(resourceName: "Vector-5").withTintColor(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), renderingMode: .alwaysOriginal),title: " on map",titleFont: .systemFont(ofSize: 6, weight: .light), tintColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), backgroundColor: #colorLiteral(red: 0.8380721211, green: 0.9466972947, blue: 0.8428769112, alpha: 1), cornerRadius: 10, clipsToBounds: true)
    let timeButton = UIButton(type: .system, image: #imageLiteral(resourceName: "Vector-5").withTintColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), renderingMode: .alwaysOriginal),title: " 16:30", titleFont: .systemFont(ofSize: 6, weight: .light), tintColor: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), backgroundColor: #colorLiteral(red: 0.7475301623, green: 0.8876212239, blue: 0.9993295074, alpha: 1), cornerRadius: 10, clipsToBounds: true)
    let dateButton = UIButton(type: .system, image: #imageLiteral(resourceName: "Vector-6").withTintColor(.black, renderingMode: .alwaysOriginal),title: " 13/04/2020", titleFont: .systemFont(ofSize: 12, weight: .light), tintColor: .init(white: 0.5, alpha: 1), backgroundColor: .clear, cornerRadius: 10, clipsToBounds: true)
    let datelabel = UILabel(text: "Date", font: .systemFont(ofSize: 15, weight: .light))
    let timeLabel = UILabel(text: "Time", font: .systemFont(ofSize: 15, weight: .light))
    let descriptionLabel = UILabel(text: "Description", font: .systemFont(ofSize: 15, weight: .medium))
    let descTextlabel: UILabel = {
       let label = UILabel()
        label.attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: NSParagraphStyle()])
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    let containerAvatar: UIView = {
        let container = UIView()
        let iV = UIImageView(image: #imageLiteral(resourceName: "banner-13-13").withRenderingMode(.alwaysOriginal), cornerRadius: 15, clipsToBounds: true, contentMode: .scaleAspectFill)
        let iV2 = UIImageView(image: #imageLiteral(resourceName: "BLOG_COVER_IMAGE-1-1").withRenderingMode(.alwaysOriginal), cornerRadius: 15, clipsToBounds: true, contentMode: .scaleAspectFill)
        container.addSubview(iV)
        container.addSubview(iV2)
        container.customSize(size: .init(width: 48, height: 30))
        iV.customLayout(leading: container.leadingAnchor, size: .init(width: 30, height: 30), yAxis: container.centerYAnchor)
        iV2.customLayout(leading: iV.trailingAnchor,bottom: iV.bottomAnchor, padding: .init(top: 0, left: -12, bottom: 0, right: 0) , size: .init(width: 30, height: 30))
        return container
    }()
    
    
    let participantsButton = UIButton(type: .system, title: "View all participants", titleFont: .systemFont(ofSize: 10, weight: .light), tintColor: .init(white: 0.5, alpha: 1), backgroundColor: .clear, cornerRadius: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        image.customSize(size: .init(width: frame.width - 20, height: 200))
        mapButton.customSize(size: .init(width: 50, height: 20))
        timeButton.customSize(size: .init(width: 50, height: 20))
        dateButton.customSize(size: .init(width: 80, height: 20))
        participantsButton.customSize(size: .init(width: 100, height: 20))
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.minimumScaleFactor = 0.5
        addSubview(registrationButton)
        let imageStack = VerticalStackView(arrangedSubviews: [backButton, image], spacing: 20)
        addSubview(imageStack)
        imageStack.alignment = .leading
        imageStack.customLayout(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 15, bottom: 0, right: 15) )
        registrationButton.customLayout(top: imageStack.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 15) )
        let eventStack = VerticalStackView(arrangedSubviews: [titleLabel, StackView(arrangedSubviews: [locationLabel, mapButton], spacing: 3)], spacing: 10)
        addSubview(eventStack)
        eventStack.customLayout(top: imageStack.bottomAnchor, leading: leadingAnchor, trailing: registrationButton.leadingAnchor, padding: .init(top: 25, left: 15, bottom: 0, right: 20))
        let dateTimeStack = StackView(arrangedSubviews: [VerticalStackView(arrangedSubviews: [datelabel, dateButton], spacing: 5), UIView(), VerticalStackView(arrangedSubviews: [timeLabel, timeButton], spacing: 5)], spacing: 5)
        addSubview(dateTimeStack)
        dateTimeStack.customLayout(top: eventStack.bottomAnchor, leading: leadingAnchor,trailing: eventStack.trailingAnchor, padding: .init(top: 25, left: 15, bottom: 0, right: 0))
        let participantsStack = StackView(arrangedSubviews: [containerAvatar, participantsButton], spacing: 3)
        addSubview(participantsStack)
        participantsStack.customLayout(top: dateTimeStack.bottomAnchor, leading: leadingAnchor, padding: .init(top: 25, left: 15, bottom: 0, right: 0))
        let descStack = VerticalStackView(arrangedSubviews: [descriptionLabel, descTextlabel], spacing: 12)
        addSubview(descStack)
        descStack.customLayout(top: participantsStack.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 25, left: 15,bottom: 0, right: 15))
    }
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
