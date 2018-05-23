//
//  AddOrganizationNewsVC.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class AddOrganizationNewsVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: - Actions

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func send(_ sender: UIBarButtonItem) {
        let news = OrganizationNews(key: nil, title: titleTextField.text!, text: messageTextView.text, date: Date(), imageUrlsCollection: [:], tagsCollection: [:])
        DataService.instance.uploadOrganizationNews(news) { (status) in
            print(status)
        }
        dismiss(animated: true)
    }
    
}

extension AddOrganizationNewsVC: UITextViewDelegate {
    
}
