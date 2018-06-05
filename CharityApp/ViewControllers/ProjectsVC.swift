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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    func configure(_ cell: ProjectCell, for project: Project) {
        cell.titleLabel.text = project.title
        cell.dateLabel.text = dateFormatter.string(from: project.date)
        cell.textView.text = project.text
        cell.raiseMoneyStatusLabel.text = "\(project.collectedMoney)/\(project.needMoney)"
        cell.raiseMoneyStatusProgressView.progress = Float(project.progress)
        cell.delegate = self
        cell.project = project
        
        if let currentUser = AuthService.instance.currentUser {
            cell.isSubscribed = currentUser.isSubscribedProject(project)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdenifiers.editProject {
            let navigationController = segue.destination as! UINavigationController
            let configureProjectVC = navigationController.topViewController as! ConfigureProjectVC
            let cellSender = sender as! ProjectCell
            configureProjectVC.project = cellSender.project
        } else if segue.identifier == SegueIdenifiers.showProjectDetails {
            let projectDetailsVC = segue.destination as! ProjectDetailsVC
            let cellSender = sender as! ProjectCell
            projectDetailsVC.project = cellSender.project
        }
    }
}

extension ProjectsVC: ProjectCellDelegate {
    func projectCellDidSubscribe(_ cell: UITableViewCell, toProject project: Project) {
        if let currentUser = AuthService.instance.currentUser {
            DataService.instance.subcribeUser(currentUser, toProject: project) { (status) in
                if status, let key = project.key {
                    currentUser.subcribedProjectsKeys.append(key)
                }
            }
        }
    }
    
    func projectCellDidUnsubscribe(_ cell: UITableViewCell, fromProject project: Project) {
        if let currentUser = AuthService.instance.currentUser {
            DataService.instance.unsubcribeUser(currentUser, fromProject: project) { (status) in
                if status {
                    for i in 0..<currentUser.subcribedProjectsKeys.count {
                        if currentUser.subcribedProjectsKeys[i] == project.key {
                            currentUser.subcribedProjectsKeys.remove(at: i)
                        }
                    }
                }
            }
        }
    }
    
    func projectCellDidTapMoreButton(_ cell: ProjectCell, onProject project: Project) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let moreInfoAction = UIAlertAction(title: "More Info", style: .default) { (_) in
            self.performSegue(withIdentifier: SegueIdenifiers.showProjectDetails, sender: cell)
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            self.performSegue(withIdentifier: SegueIdenifiers.editProject, sender: cell)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            let alert = UIAlertController(title: "Are you shure want to delete this project?", message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                DataService.instance.removeProject(project, deleteComplete: { (status) in
                    if status {
                        let index = self.projects.index(of: project)
                        if let index = index {
                            self.projects.remove(at: index)
                            self.tableView.reloadData()
                        }
                        // TODO: Add notification that deletion completed
                    } else {
                        // TODO: Add notification that deletion can't be completed
                    }
                })
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
        static let showProjectDetails = "ShowProjectDetails"
    }
}
