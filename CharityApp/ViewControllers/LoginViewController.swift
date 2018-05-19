
//  LoginViewController.swift
//  CharityApp
//
//  Created by Artur on 4/30/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var buttonsWithFilledBackground: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        buttonsWithFilledBackground.forEach { button in
            print(button)
            button.roundCorners(withRadius: 5)
        }
    }
    
    @IBAction func beginEditingPassword(_ sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func signIn() {
        // TODO: Add database business here
        
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
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            AuthService.instance.loginUser(withEmail: email, andPassword: password) { (status, error) in
                
            }
        }
        
        performSegue(withIdentifier: "Login", sender: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
