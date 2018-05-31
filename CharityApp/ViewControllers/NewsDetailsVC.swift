//
//  NewsDetailsVC.swift
//  CharityApp
//
//  Created by Artur on 5/28/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NewsDetailsVC: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var bottomButtonsStackView: UIButton!
    @IBOutlet weak var deleteTableViewCell: UITableViewCell!
    @IBOutlet weak var projectPickerTableViewCell: UITableViewCell!
    
    
    // MARK: - Properties
    
    var news: News?
    var isOrganizationNews = true
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectPickerTableViewCell.imageView!.image = imageWithImage(#imageLiteral(resourceName: "logo-simplified"), scaledToSize: CGSize(width: 30, height: 30))
        projectPickerTableViewCell.textLabel!.text = "Organization"
        // If edit news
        if let news = news {
            title = "Edit news"
            titleTextField.text = news.title
            messageTextView.text = news.text
            if news is OrganizationNews {
                projectPickerTableViewCell.isHidden = false
            } else if news is ProjectNews {
                projectPickerTableViewCell.isHidden = true
            }
        }
//        bottomButtonsStackView.bindToKeyboard()
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func send(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Do you want to add news?", message: "Are you shure want to add the news?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if self.isOrganizationNews {
                if let _ = self.news {
                    // TODO: Update existed organization news
                } else {
                    let news = OrganizationNews(key: nil, title: self.titleTextField.text!, text: self.messageTextView.text, date: Date(), imageUrlsCollection: [:], tagsCollection: [])
                    DataService.instance.uploadOrganizationNews(news) { (status) in
                        print(status)
                    }
                }
            } else {
                if let _ = self.news {
                    // TODO: Update existed project news
                } else {
                    // TODO: Add existed project news
                }
            }
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    // MARK: - Navigation

    @IBAction func projectPickerDidPickProject(_ segue: UIStoryboardSegue) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1))!
        
        let controller = segue.source as! ProjectPickerVC
        if let project = controller.project {
            news = ProjectNews(key: nil, title: "", text: "", date: Date())
            cell.imageView!.isHidden = true
            cell.textLabel!.text = project.title
        } else {
            cell.imageView!.isHidden = false
            cell.textLabel!.text = "Organization"
        }
    }
}

extension NewsDetailsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Hide 'delete' section if add new news
        if let _ = news {
            return 5
        } else {
            return 4
        }
    }
}
