
//  LoginViewController.swift
//  CharityApp
//
//  Created by Artur on 4/30/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var buttonsWithFilledBackground: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        buttonsWithFilledBackground.forEach { button in
            print(button)
            roundCorners(of: button, withCornerRadius: 5)
        }
    }
    
    @IBAction func beginEditingPassword(_ sender: UITextField) {
        passwordTextField.becomeFirstResponder()
    }
    
    @IBAction func login() {
        // TODO: Add database business here
        
        // Prevent try to login with empty fields
        if loginTextField.text!.isEmpty {
            shakeView(loginTextField)
            loginTextField.becomeFirstResponder()
            return
        } else if passwordTextField.text!.isEmpty {
            shakeView(passwordTextField)
            passwordTextField.becomeFirstResponder()
            return
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
