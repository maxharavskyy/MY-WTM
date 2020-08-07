//
//  Api.swift
//  MY WTM
//
//  Created by Макс Гаравський on 25.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class Api {
    
    //MARK:- Firebase auth methods
    
    //creating firebase doc with user data, sending email verificsation and calling setUserInfo method from singleton
    
    static func signUp(username: String, email: String, password: String, onSuccess: @escaping() -> (), onError: @escaping(_ errorMessage: String) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            if let authData = authResult {
                let docData = ["fullName" : username, "uid" : authData.user.uid, "email" : authData.user.email]
                let doc = authData.user.uid


                Firestore.firestore().collection("users").document(doc).setData(docData as [String : Any]) { (err) in
                    if err != nil {
                      onError(err!.localizedDescription)
                        return
                    }
                }
                authData.user.sendEmailVerification { (err) in
                    if err == nil {
                        User.shared.setUserInfo(dictionary: docData as [String : Any])
                       onSuccess()
                    } else {
                        onError(err!.localizedDescription)
                        return
                    }
                }
            }
        }
    }
   
    
    //Providing sign in, in case when user already verified his email, otherwise show an error
    static func signIn(email: String, password: String, onSuccess: @escaping() -> (), onError: @escaping(_ errorMessage: String) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            } else if authResult?.user.isEmailVerified == false {
                onError("Please verify your email")
                return
            } else {
                onSuccess()
            }
        }
    }
        
    static func passwordReset(email: String, onSuccess: @escaping() -> (), onError: @escaping(_ errorMessage: String) -> ())  {
        Auth.auth().sendPasswordReset(withEmail: email) { (err) in
            if  err != nil {
                onError(err!.localizedDescription)
                return
            } else {
                onSuccess()
            }
            
        }
    }
    
    
    //MARK:-  Google SignIn
    
    //Providing signIn with google credential, setting obtained data to firebase doc
    static func googleSignIn(credentials: AuthCredential, onSuccess: @escaping() -> (), onError: @escaping(_ errorMessage: String) -> ()) {
        Auth.auth().signIn(with: credentials) { (authResult, err) in
            if err != nil {
                onError(err!.localizedDescription)
                return
            } else if authResult!.additionalUserInfo?.isNewUser == true {
                guard let uid = Auth.auth().currentUser?.uid else {return}
                guard let user: GIDGoogleUser = GIDSignIn.sharedInstance().currentUser else {return}
                let  imageURL =  user.profile.imageURL(withDimension: 300)?.absoluteString
                let docData = ["fullName" : user.profile.name!, "uid" : uid, "email" : user.profile.email!, "imageUrl" : imageURL ?? "" ] as [String : Any]
                Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
                    if err != nil {
                        onError(err!.localizedDescription)
                        return
                    } else {
                        onSuccess()
                    }
                }
            } else {
                onSuccess()
            }
        }
    }

    
    
}
