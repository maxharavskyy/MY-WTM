//
//  SceneDelegate.swift
//  MY WTM
//
//  Created by Макс Гаравський on 20.05.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.makeKeyAndVisible()
            window?.rootViewController = MainScreenController()
                //UINavigationController(rootViewController: FeedController())
        }
    }

}
