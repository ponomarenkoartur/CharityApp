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
        let alert = UIAlertController(title: "Do you want to add project?", message: "Are you shure want to add the project?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if let _ = self.project {
                // TODO: Update existed project news
            } else {
                // TODO: Replace 'needMoney' value '0' with real value
                let project = Project(key: nil, title: self.titleTextField!.text!, text: self.textView!.text, date: Date(), isCompleted: false, needMoney: 0)
                DataService.instance.uploadProject(project, sendComplete: { (status) in
                    print(status)
                })
            }
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
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
