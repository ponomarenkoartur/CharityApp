//
//  ProjectsVC.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectsVC: UITableViewController {

    var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.instance.getAllProjects { (projects) in
            self.projects = projects
            self.projects.sort(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let project = projects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        configure(cell, for: project)
        print("=================\(project.text)")
        return cell
        
    }

    func configure(_ cell: ProjectCell, for project: Project) {
        cell.titleLabel.text = project.title
        cell.dateLabel.text = dateFormatter.string(from: project.date)
        cell.textView.text = project.text
        cell.raiseMoneyStatusLabel.text = "\(project.collectedMoney)/\(project.needMoney)"
        cell.raiseMoneyStatusProgressView.progress = Float(project.progress)
    }

}
