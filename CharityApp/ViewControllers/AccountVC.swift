//
//  AccountController.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class AccountVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0,
            indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(title: nil, message: "Are you shure want to log out?", preferredStyle: .actionSheet)
            let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (_) in
                AuthService.instance.logout(handler: { (logoutComplete) in
                    if logoutComplete {
                        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                        self.present(loginVC!, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Can not log out right now. It may be problem with internet connection.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                    }
                })
            }
            alert.addAction(logoutAction)
            present(alert, animated: true)
        }
    }
}
