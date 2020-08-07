//
//  ProfileCollectionController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 13.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import GoogleSignIn


class ProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
   
    fileprivate let headerId = "headerId"
    fileprivate let cellId = "cellId"
    
    var image: UIImage?
    var user = User.shared   // setting already created object to local variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9617878795, green: 0.9560701251, blue: 0.9661827683, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isScrollEnabled = false
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellId)
        uploadProfilePhoto()
        print("user in profile:", User.shared.email ?? "")
        
    }
    
    //MARK:- Singleton object method
    
    //here we take image data from singleton object, load it with SDWebImage Manager, then set to local variable
    
   func uploadProfilePhoto() {
        user.getUserPhoto { (image) in
            self.image = image
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK:- Image Picker Controller delegate method
    
    //here we get pickedImage data, appeal to our singleton object and call method to set new data
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.editedImage] as? UIImage
        let filename = UUID().uuidString
            self.image = selectedImage
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            dismiss(animated: true)
            user.setUserImage(filename: filename, image: selectedImage, onError: { (err) in
                print(err.localizedDescription)
                return
            }) {
                print("Success image saving")
                print(filename)
            }
    }
    
    //MARK:- OBJ-C target-action methods
    
    @objc func handleDismiss() {
       navigationController?.popViewController(animated: true)
    }
    
    @objc func handleImagePick() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @objc func handleDeleteUser() {
        user.deleteUser(onSuccess: {
            self.navigationController?.popViewController(animated: true)
        }) { (err) in
            print(err.localizedDescription)
        }
    }
    
    //MARK:- Header stuff
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! ProfileHeader
        header.backButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        header.imageButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        header.imageButton.addTarget(self, action: #selector(handleImagePick), for: .touchUpInside)
        header.changeImageButton.addTarget(self, action: #selector(handleImagePick), for: .touchUpInside)
        header.deleteUser.addTarget(self, action: #selector(handleDeleteUser), for: .touchUpInside)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height / 2)
    }
    //MARK:- Cell stuff
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCell
        cell.nameLabel.text = user.fullname
        cell.tableController.handler = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        cell.tableController.reloadHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: collectionView.frame.height / 1.8)
    }
    
    //MARK:- collection view layout creation
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
