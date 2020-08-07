//
//  Event.swift
//  MY WTM
//
//  Created by Макс Гаравський on 06.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase


class Event {
    let category: String?
    let title: String?
    let imageUrl: String?
    let date: String?
    let eventId: String?
    
    var participants: [String]? = []
   
    init(dictionary: [String : Any]) {
        self.category = dictionary["category"] as? String 
        self.title = dictionary["title"] as? String
        self.imageUrl = dictionary["imageUrl"] as? String
        self.date  = dictionary["date"] as? String
        self.participants = (dictionary["participants"] as? [String])
        self.eventId = dictionary["eventId"] as? String
    }
    

    func registerForEvent(user: User,onError: @escaping (Error) -> (), onSuccess: @escaping () -> ()) {
        guard let eventId = eventId else {return}
        Firestore.firestore().collection("events").document(eventId).updateData(["participants" : FieldValue.arrayUnion([user.uid as Any])]) { (err) in
            if let err = err {
                onError(err)
                return
            }
            onSuccess()
        }
    }
   
    
    
}
