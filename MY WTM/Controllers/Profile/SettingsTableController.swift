//
//  SettingsTableController.swift
//  MY WTM
//
//  Created by Макс Гаравський on 13.06.2020.
//  Copyright © 2020 Макс Гаравський. All rights reserved.
//

import UIKit
import Firebase

class SettingsTableController: UITableViewController {
   
    var handler: (() -> ())? 
    var reloadHandler: (() -> ())?
    var user = User.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SettingsTableCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
    }
    
    //MARK:- Row selection handling methods
    
    
    //here we create view controller, set appropriate labels description, recieve info from textfield, and set new info to user 
   func nameEdit(user: User) {
        let controller = ChangeSettingsController()
        controller.desc = "profile name"
        controller.textField.placeholder = user.fullname
        controller.userInfoHandler = { info in
            user.setUserName(name: info) {
                controller.dismiss(animated: true) {
                   self.reloadHandler?()
                }
            }
        }
        present(controller, animated: true)
    }
    
    func emailEdit(user: User) {
        let controller = ChangeSettingsController()
        controller.textField.placeholder = user.email
        controller.userInfoHandler = { info  in
            user.setUserEmail(email: info, onError: { (err) in
                print(err.localizedDescription)
                return
            }) {
                controller.dismiss(animated: true) {
                    print("Success email changing")
                }
            }
        }
        present(controller, animated: true)
    }
    
    func passwordEdit(user: User) {
        let controller = ChangeSettingsController()
        controller.desc = "password"
        controller.textField.placeholder = "enter here"
        controller.allowTextInput = true
        controller.textField2.isSecureTextEntry = true
        controller.textField.isSecureTextEntry = true
        controller.userInfoHandler = { info in
            user.setUserPassword(password: info, onError: { (err) in
                print(err.localizedDescription)
                return
            }) {
                controller.dismiss(animated: true) {
                    print("Success change password")
                }
            }
        }
        present(controller, animated: true)
    }
    
    func handleLogout() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (_) in
            try? Auth.auth().signOut()
            self.handler?()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true, completion: nil)
    }

    //MARK:- TableView row stuff
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       switch indexPath.row {
        case 0:
            emailEdit(user: user)
        case 1:
            passwordEdit(user: user)
        case 2:
            nameEdit(user: user)
        case 3:
            handleLogout()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableCell
        cell.selectionStyle = .none
        if indexPath.row == 1 {
            cell.imageVi.image = #imageLiteral(resourceName: "Vector-8").withRenderingMode(.alwaysOriginal)
            cell.imageVi.backgroundColor = #colorLiteral(red: 0.7915216088, green: 0.9070423245, blue: 1, alpha: 1)
            cell.label.text = "Change Password"
            cell.descLabel.text = "Change your current password"
        } else if indexPath.row == 2 {
            cell.imageVi.image = #imageLiteral(resourceName: "Vector-9").withRenderingMode(.alwaysOriginal)
            cell.imageVi.backgroundColor = #colorLiteral(red: 0.8576024771, green: 0.8717026114, blue: 1, alpha: 1)
            cell.label.text = "Profile"
            cell.descLabel.text = "Change name, surname"
        } else if indexPath.row == 3 {
            cell.imageVi.image = #imageLiteral(resourceName: "Vector").withRenderingMode(.alwaysOriginal)
            cell.imageVi.backgroundColor = #colorLiteral(red: 1, green: 0.9536677003, blue: 0.834220469, alpha: 1)
            cell.label.text = "Log out"
            cell.descLabel.text = "Proceed to log out "
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = .init(white: 0.95, alpha: 1)
    }
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
            cell!.contentView.backgroundColor = .clear
        }
           
    }
}







