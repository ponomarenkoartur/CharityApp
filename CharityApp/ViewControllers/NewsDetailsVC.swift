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
    
    // MARK: - Properties
    
    var news: News?
    var isOrganizationNews = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If existing news is editing
        if let news = news {
            title = "Edit news"
            titleTextField.text = news.title
            messageTextView.text = news.text
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
        isOrganizationNews = controller.isOrganizationNews
        if isOrganizationNews {
            cell.imageView!.image = #imageLiteral(resourceName: "logo-simplified")
            cell.textLabel!.text = "Organization"
        } else if let project = controller.project {
            news = ProjectNews(key: nil, title: "", text: "", date: Date(), parentNeedKey: project.key, parentNeedTitle: project.title)
            cell.textLabel!.text = project.title
        }
    }
}
