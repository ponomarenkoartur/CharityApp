//
//  RecoverPasswordVC.swift
//  
//
//  Created by Artur on 5/3/18.
//

import UIKit

class RecoverPasswordVC: UITableViewController {
    
    // MARK: Outlets

    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: View behavior
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    // MARK: Action
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
