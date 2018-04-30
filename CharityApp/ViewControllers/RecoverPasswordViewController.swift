//
//  RecoverPasswordViewController.swift
//  
//
//  Created by Artur on 4/30/18.
//

import UIKit

class RecoverPasswordViewController: UITableViewController {

    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    // MARK: View Behaviour
    
    override func viewWillDisappear(_ animated: Bool) {
        emailTextField.resignFirstResponder()
    }
    
    // MARK: Action
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}
