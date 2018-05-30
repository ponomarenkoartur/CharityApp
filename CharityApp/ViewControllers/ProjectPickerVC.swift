//
//  ProjectPickerVC.swift
//  CharityApp
//
//  Created by Artur on 5/28/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectPickerVC: UITableViewController {

    var projects: [Project]!
    var project: Project?
    
    override func viewDidLoad() {
        let project0 = Project(key: nil, title: "Project0", text: "", date: Date(), isCompleted: true, needMoney: 0)
        let project1 = Project(key: nil, title: "Project1", text: "", date: Date(), isCompleted: true, needMoney: 0)
        let project2 = Project(key: nil, title: "Project2", text: "", date: Date(), isCompleted: true, needMoney: 0)
        
        projects = []
        projects.append(project0)
        projects.append(project1)
        projects.append(project2)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView, withIdentifier: "ProjectCell")
        if indexPath.row == 0 {
            cell.imageView!.image = imageWithImage(#imageLiteral(resourceName: "logo-simplified"), scaledToSize: CGSize(width: 30, height: 30))
            cell.textLabel!.text = "Organization"
        } else {
            cell.textLabel!.text = projects[indexPath.row - 1].title
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickedProject" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                if indexPath.row != 0 {
                    project = projects[indexPath.row - 1]
                }
            }
        }
    }
}
