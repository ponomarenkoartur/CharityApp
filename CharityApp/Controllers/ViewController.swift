//
//  ViewController.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    // MARK: - Properties
    
    var myFireDatabase: MyFireDatabase!
    var organizations = [Organization]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFireDatabase.root.observe(.value, with: { (snapshot) in
            var newOrganizations = [Organization]()
            for item in snapshot.children {
                print(item)
                let organization = Organization(snapshot: item as! DataSnapshot)
                newOrganizations.append(organization)
            }
            self.organizations = newOrganizations
            self.tableView.reloadData()
        })
        
        print(self.organizations)
    }

    // MARK: - Actions
    
    @IBAction func addOrganization(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "AddOrganization", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first, let text = textField.text else { return }
            let organizationInfo = OrganizationInfo(name: text, description: "", contactInformation: "", defaultAccountNumber: "")
            let organization = Organization.init(info: organizationInfo)
            self.myFireDatabase.addOrganization(organization)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension ViewController {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationCell", for: indexPath)
        let organization = organizations[indexPath.row]
        cell.textLabel?.text = organization.info.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let organization = organizations[indexPath.row]
        let key = organization.info.name
        myFireDatabase.deleteOrganizationWithKey(key)
    }
}

