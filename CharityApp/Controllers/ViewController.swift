//
//  ViewController.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: - Properties
    
    var myFireDatabase: MyFireDatabase!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let organizationInfo = OrganizationInfo(name: "Example22", description: "", contactInformation: "", defaultAccountNumber: "")
        let organization = Organization(info: organizationInfo)
        let organizationKey = organization.info.name
        let news0 = News(title: "News0", text: "", date: Date(), imageURLs: nil)
        let need0 = Need(title: "Need0", text: "", isCompleted: false, likes: 0, date: Date(), imageURLs: nil, tags: nil, news: nil)
        let news1 = News(title: "News0", text: "", date: Date(), imageURLs: nil)
        myFireDatabase.addOrganization(organization)
        myFireDatabase.addNews(news0, toOrganizationWithKey: organizationKey)
        myFireDatabase.addNeed(need0, toOrganizationWithKey: organizationKey)
        
    }

    // MARK: - Actions
    
    @IBAction func addOrganization(_ sender: UIBarButtonItem) {

    }
}

extension ViewController {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationCell", for: indexPath)
        
        return cell
    }
}

