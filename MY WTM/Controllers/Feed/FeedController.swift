//
//  ProfileController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 21.05.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage
import GoogleSignIn

class FeedController: UICollectionViewController, UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout, LoginControllerDelegate {
    
    fileprivate let cellId = "cellId"
    
    lazy var user: User? = User.shared
    
    lazy var userImage: UIImage = #imageLiteral(resourceName: "Profile Avatar копія").withTintColor(.init(white: 0.1, alpha: 0.8), renderingMode: .alwaysOriginal)
    
    var events: [Event] = []
    
    private let refreshControl = UIRefreshControl()
    
    //MARK:- Life cycle of UIViewController
    //опрацювання змін в стані view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NavigationBarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
       
        fetchUser()
        fetchEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil || Auth.auth().currentUser?.isEmailVerified == false {
            let loginController = LoginController()
            loginController.delegate = self
            let navController = UINavigationController(rootViewController: loginController)
            navController.modalPresentationStyle = .fullScreen
            userImage = #imageLiteral(resourceName: "Profile Avatar копія").withTintColor(.init(white: 0.1, alpha: 0.8), renderingMode: .alwaysOriginal)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.present(navController, animated: true)
        }
    }

    //MARK:- Objective-C target-action methods
    @objc func refresh() {
        fetchUser()
    }
    
    //MARK:- Getting user data
    
    // here we call getter method from singleton object, defining current user from firebase and setting obtained data to our object, setting image and reload UI
    
    func fetchUser() {
        user?.getUserinfo(onError: { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
        }, onSuccess: { (image) in
            self.userImage = image
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        refreshControl.endRefreshing()
    }
   
    func fetchEvents() {
      Firestore.firestore().collection("events").getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            for event in querySnapshot!.documents {
                self.events.append(Event(dictionary: event.data()))
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK:- Delegation method call
    
    func didFinishLoggingIn() {
        fetchUser()
    }
    
    //MARK:- Header stuff
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! NavigationBarHeader
        header.profileButt.setImage(userImage.withRenderingMode(.alwaysOriginal), for: .normal)
        header.openProfileHandler = {
            let profileController = ProfileController()
            self.navigationController?.pushViewController(profileController, animated: true)
        }
        header.openSearchHandler = {
            let searchController = SearchController()
            searchController.events = self.events
            self.navigationController?.pushViewController(searchController, animated: true)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    //MARK:- Cell rendering and cordination

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!FeedCell//FeedCell
        cell.cellController.event = events[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventController = EventController()
        eventController.event = events[indexPath.item]
        navigationController?.pushViewController(eventController, animated: true)
    }
    
    
  //MARK:- CollectionView Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 50, left: 0, bottom: 20, right: 0)
    }
   
    
   //MARK:- Creation of layout for collection View
   init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
