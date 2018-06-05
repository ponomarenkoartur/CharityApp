//
//  ConfigureNewsVC.swift
//  CharityApp
//
//  Created by Artur on 5/28/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ConfigureNewsVC: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var deleteTableViewCell: UITableViewCell!
    @IBOutlet weak var projectPickerTableViewCell: UITableViewCell!
    
    // MARK: - Properties
    
    var news: News?
    var project: Project? {
        didSet {
            if let _ = project {
                isOrganizationNews = false
            }
        }
    }
    var isOrganizationNews = true
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial appearence of 'project picker' cell
        if isOrganizationNews {
            projectPickerTableViewCell.imageView!.image = imageWithImage(#imageLiteral(resourceName: "logo-simplified"), scaledToSize: CGSize(width: 30, height: 30))
            projectPickerTableViewCell.textLabel!.text = "Organization"
        } else if let project = project {
            projectPickerTableViewCell.textLabel!.text = project.title
            projectPickerTableViewCell.accessoryType = .none
        }
        // If edit news
        if let news = news {
            title = "Edit news"
            titleTextField.text = news.title
            messageTextView.text = news.text
            // If edit organization news
            if news is OrganizationNews {
                projectPickerTableViewCell.isHidden = false
            } else if news is ProjectNews {
                projectPickerTableViewCell.isHidden = true
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func send(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Do you want to add news?", message: "Are you shure want to add the news?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if self.isOrganizationNews {
                if let news = self.news as? OrganizationNews {
                    // Edit existing organization news
                    news.title = self.titleTextField.text!
                    news.text = self.messageTextView.text
                    DataService.instance.updateOrganizationNews(news) { (status) in
                        print(status)
                    }
                } else {
                    // Add organization news
                    let news = OrganizationNews(key: nil, title: self.titleTextField.text!, text: self.messageTextView.text, date: Date(), imageUrlsCollection: [:], tagsCollection: [])
                    DataService.instance.uploadOrganizationNews(news) { (status) in
                        print(status)
                    }
                }
            } else if let project = self.project,
                let projectKey = project.key {
                if let news = self.news as? ProjectNews {
                    // Edit existing project news
                    news.title = self.titleTextField.text!
                    news.text = self.messageTextView.text
                    DataService.instance.updateProjectNews(news, ofProject: project, updateComplete: { (status) in
                        print(status)
                    })
                } else {
                    // Add project news
                    
                    let news = ProjectNews(key: nil, title: self.titleTextField.text!, text: self.messageTextView.text, parentProjectKey: projectKey, parentProjectTitle: project.title)
                    DataService.instance.uploadProjectNews(news, ofProject: project, sendComplete: { (status) in
                        print(status)
                    })
                }
            }
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // MARK: Tableview delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if !isOrganizationNews {
            return nil
        } else {
            return indexPath
        }
    }
    
    // MARK: - Navigation

    @IBAction func projectPickerDidPickProject(_ segue: UIStoryboardSegue) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))!
        
        let controller = segue.source as! ProjectPickerVC
        if let project = controller.project,
            let projectKey = project.key {
            news = ProjectNews(key: nil, title: "", text: "", parentProjectKey: projectKey, parentProjectTitle: project.title)
            cell.imageView!.isHidden = true
            cell.textLabel!.text = project.title
        } else {
            cell.imageView!.isHidden = false
            cell.textLabel!.text = "Organization"
        }
    }
}

extension ConfigureNewsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Hide 'delete' section if add new news
        if let _ = news {
            return 5
        } else {
            return 4
        }
    }
}
