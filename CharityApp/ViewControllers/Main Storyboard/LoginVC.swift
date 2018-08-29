
//  LoginVC.swift
//  CharityApp
//
//  Created by Artur on 4/30/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func beginEditingPassword(_ sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func signIn() {
        // Prevent try to sign in with empty fields
        if emailTextField.text!.isEmpty {
            emailTextField.shake()
            emailTextField.becomeFirstResponder()
            return
        } else if passwordTextField.text!.isEmpty {
            passwordTextField.shake()
            passwordTextField.becomeFirstResponder()
            return
        }
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else { return }
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (status, errorCode) in
            if status {
                DataService.instance.getCurrentUser { (user) in
                    AuthService.instance.currentUser = user
                    self.performSegue(withIdentifier: "Login", sender: nil)
                }
            } else if let errorCode = errorCode {
                // TODO: Replace standart alert controller with custim hud view
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                
                switch errorCode {
                case .userNotFound:
                    alert.title = "Wrong email"
                    alert.message = "You entered wrong email.\nThere are no user with this email."
                case .invalidEmail:
                    alert.title = "Invalid email"
                    alert.message = "Entered email is not valid."
                case .wrongPassword:
                    alert.title = "Wrong password"
                    alert.message = "You entered wrong password."
                default:
                    alert.title = "Error"
                }
                
                self.present(alert, animated: true)
            }
        }
    }
}
