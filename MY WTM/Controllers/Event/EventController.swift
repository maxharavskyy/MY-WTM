//
//  EventCollectionController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 08.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase


class EventController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "Cell"
    
    var user = User.shared
    var event: Event?
    var userImage: UIImage?
    
    lazy var participants: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(NavigationBarHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: cellId)
        getUserImage()
        fetchParticipants()
    }
    
   func getUserImage() {
        user.getUserPhoto { (image) in
            self.userImage = image
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchParticipants() {
        guard let array = event?.participants else {return}
        for uid in array {
            Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
                if let  err = err {
                    print(err.localizedDescription)
                    return
                }
                guard let userData = snapshot?.data() else {return}
                let userName = userData["fullName"]
                self.participants.append(userName as! String)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    

   override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! NavigationBarHeader
        header.profileButt.setImage(userImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        header.openProfileHandler = {
            let profileController = ProfileController()
            self.navigationController?.pushViewController(profileController, animated: true)
        }
        header.openSearchHandler = {
            let searchController = SearchController()
            self.navigationController?.pushViewController(searchController, animated: true)
        }
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventCell
        cell.titleLabel.text = event?.title
        cell.dateButton.setTitle(event?.date, for: .normal)
        cell.image.sd_setImage(with: URL(string: event?.imageUrl ?? ""))
        cell.backButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        cell.descTextlabel.attributedText = NSAttributedString(string: "\(participants)")
        return cell
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 100)
    }
    
    @objc fileprivate func handleDismiss() {
        navigationController?.popViewController(animated: true)
    }
    
   
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
