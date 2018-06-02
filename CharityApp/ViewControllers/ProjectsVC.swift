//
//  ProjectsVC.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectsVC: UITableViewController {

    // MARK: - Properties
    
    var projects = [Project]()
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllProjects { (projects) in
            self.projects = projects.sorted(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let project = projects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.projectCell, for: indexPath) as! ProjectCell
        configure(cell, for: project)
        return cell
        
    }

    func configure(_ cell: ProjectCell, for project: Project) {
        cell.titleLabel.text = project.title
        cell.dateLabel.text = dateFormatter.string(from: project.date)
        cell.textView.text = project.text
        cell.raiseMoneyStatusLabel.text = "\(project.collectedMoney)/\(project.needMoney)"
        cell.raiseMoneyStatusProgressView.progress = Float(project.progress)
        cell.delegate = self
        cell.project = project
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdenifiers.editProject {
            let navigationController = segue.destination as! UINavigationController
            let projectDetailsVC = navigationController.topViewController as! ProjectDetailsVC
            
            let cellSender = sender as! ProjectCell
            projectDetailsVC.project = cellSender.project
        }
    }
}

extension ProjectsVC: ProjectCellDelegate {
    func projectCellDelegateDidTapMoreButton(_ cell: ProjectCell, onProject project: Project) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let moreInfoAction = UIAlertAction(title: "More Info", style: .default) { (_) in
            
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            self.performSegue(withIdentifier: SegueIdenifiers.editProject, sender: cell)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            let alert = UIAlertController(title: "Are you shure want to delete this project?", message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                // TODO: Delete project
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(moreInfoAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension ProjectsVC {
    struct TableViewCellIdentifiers {
        static let projectCell = "ProjectCell"
    }
    
    struct SegueIdenifiers {
        static let editProject = "EditProject"
    }
}
