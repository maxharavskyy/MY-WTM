//
//  User.swift
//  MY WTM
//
//  Created by Макс Гаравський on 01.07.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class User {
    
    static let shared = User()
    
    var fullname: String?
    var email: String?
    var uid: String?
    var imageUrl: String?
    
    private init() {}
    
    
    //MARK:- Setter methods

    func setUserInfo(dictionary: [String : Any] ) {
        self.fullname = dictionary["fullName"] as? String ?? "..."
        self.imageUrl = dictionary["imageUrl"] as? String ?? "..."
        self.uid = dictionary["uid"] as? String ?? "..."
        self.email = dictionary["email"] as? String ?? "..."
    }
    
    func setUserName(name: String, onSuccess: @escaping () -> ()) {
        guard let uid = uid else {return}
        Firestore.firestore().collection("users").document(uid).updateData(["fullName" : name])
        fullname = name
        onSuccess()
    }
    
    func setUserEmail(email: String, onError: @escaping (Error) -> (), onSuccess: @escaping () -> ()) {
        guard let uid = uid else {return}
        guard let firUser = Auth.auth().currentUser else {return}
        firUser.updateEmail(to: email, completion: { (err) in
            if let err = err {
                print(err.localizedDescription)
                onError(err)
                return
            }
            Firestore.firestore().collection("users").document(uid).updateData(["email" : email])
            self.email = email
            onSuccess()
        })
    }
    
    func setUserPassword(password: String, onError: @escaping (Error) -> (), onSuccess: @escaping () -> ()) {
        guard let firUser = Auth.auth().currentUser else {return}
        firUser.updatePassword(to: password) { (err) in
            if let err = err {
                print(err.localizedDescription)
                onError(err)
                return
            }
            onSuccess()
            print("Success password update")
        }
    }
    
    
    func setUserImage(filename: String, image: UIImage?, onError: @escaping (Error) -> (), onSuccess: @escaping () -> ()) {
        guard let uploadData = image?.jpegData(compressionQuality: 0.75) else {return}
        let reference = Storage.storage().reference(withPath: "/images/\(filename)")
        reference.putData(uploadData, metadata: nil) { (nil, err) in
            if let err = err {
                print(err.localizedDescription)
                onError(err)
                return
            }
            reference.downloadURL { (url, err) in
                if let err = err  {
                    print(err.localizedDescription)
                    onError(err)
                    return
                }
                guard let url = url?.absoluteString else {return}
                print("finish downloading url :", url)
                self.imageUrl = url
                guard let uid = self.uid else {return}
                Firestore.firestore().collection("users").document(uid).updateData(["imageUrl" : url]) { (err) in
                    if let err = err {
                        print(err.localizedDescription)
                        onError(err)
                        return
                    }
                    print("finish downloading url, data ok")
                    onSuccess()
                }
            }
        }
    }
    
    //MARK:- Getter methods

    func getUserinfo(onError: @escaping (Error?) -> (), onSuccess: @escaping (UIImage) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                print("failed while fetch user", err)
                onError(err)
                return
            }
            guard let dictionary = snapshot?.data() else {
                print("No user found in Firestore")
                return
            }
            self.setUserInfo(dictionary: dictionary)
            guard let imageUrl = self.imageUrl else {return}
            let url = URL(string: imageUrl)
            SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
                guard let image = image else {return}
                onSuccess(image)
            }
        }
    }
    
    func getUserPhoto(onSuccess: @escaping (UIImage) -> () ) {
        guard let imageUrl = self.imageUrl else {return}
        let url = URL(string: imageUrl)
        SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (image, _, _, _, _, _) in
            guard let image = image else {return}
            onSuccess(image)
        }
    }
    
    
    
    // deleting user from firebase auth, and appropriate doc
    func deleteUser(onSuccess: @escaping () -> (), onError: @escaping (Error) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        user.delete { (err) in
            if let err = err {
                print(err.localizedDescription)
                onError(err)
                return
            }
            print("user was deleted")
            Firestore.firestore().collection("users").document(user.uid).delete { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    onError(err)
                    return
                }
                onSuccess()
                print("user doc was deleted")
            }
        }
    }
   
    
         
}



