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
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func signUp() {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            let user = User.init(email: email, password: password, firstName: nil, surname: nil, accountCreationDate: Date(), isAdmin: false, likedNewsIds: [], likedOrganizationNewsIds: [])
            
            
            AuthService.instance.registerUser(user) { (success, errorCode) in
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                
                if success {
                    alert.title = "Success"
                    alert.message = "Account successfully created."
                    
                    self.present(alert, animated: true) {
                        self.performSegue(withIdentifier: "LoginAfterRegistration", sender: nil)
                    }
                } else {
                    if let errorCode = errorCode {
                        // TODO: Replace standart alert controller with custim hud view
                        switch errorCode {
                        case .emailAlreadyInUse:
                            alert.title = "Error"
                            alert.message = "The account with this email already exist."
                        case .invalidEmail:
                            alert.title = "Wrong email"
                            alert.message = "You entered wrong email."
                        // TODO: Handle this error on client side
                        case .weakPassword:
                            alert.title = "Weak password"
                            alert.message = "Your password is to weak."
                        default:
                            alert.title = "Error"
                        }
                    }
                    self.present(alert, animated: true)
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
