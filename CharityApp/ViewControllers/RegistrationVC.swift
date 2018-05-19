//
//  RegistrationVC.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class RegistrationVC: UITableViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // Actions
    
    
    @IBAction func signUp() {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            let user = User.init(email: email, password: password, firstName: nil, surname: nil, accountCreationDate: Date(), isAdmin: false, likedNewsIds: [], likedOrganizationNewsIds: [])
            
            
            AuthService.instance.registerUser(user) { (success, registrationError) in
                if let error = registrationError {
                    // TODO: Handle error
                    print(error)
                } else {
                    self.performSegue(withIdentifier: "LoginAfterRegistration", sender: nil)
                }
            }
        }
    }
}

extension RegistrationVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            // Check if fields are not empty
            if emailTextField.text!.isEmpty {
                emailTextField.becomeFirstResponder()
            } else if passwordTextField.text!.isEmpty {
                passwordTextField.becomeFirstResponder()
            } else {
                signUp()
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        // Check if one of the fields is empty
        if newText.length > 0 {
            if textField == emailTextField,
                !passwordTextField.text!.isEmpty {
                signUpBarButton.isEnabled = true
            } else if textField == passwordTextField,
                !emailTextField.text!.isEmpty {
                signUpBarButton.isEnabled = true
            }
        } else {
            signUpBarButton.isEnabled = false
        }
        return true
    }
}
