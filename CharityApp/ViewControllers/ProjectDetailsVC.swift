//
//  ProjectDetailsVC.swift
//  CharityApp
//
//  Created by Artur on 6/1/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectDetailsVC: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Properties
    
    var project: Project?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let project = project {
            title = "Edit project"
            titleTextField.text = project.title
            textView.text = project.text
        }
    }
    
    // MARK: - Actions
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        // TODO: Add firebase business here
    }
}

extension ProjectDetailsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Hide 'delete' section if add new project
        if let _ = project {
            return 5
        } else {
            return 4
        }
    }
}
