//
//  ProjectDetailsVC.swift
//  CharityApp
//
//  Created by Artur on 6/4/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectDetailsVC: UITableViewController {
    
    // MARK: - Properties
    
    var project: Project?
    var newsCollection = [ProjectNews]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return newsCollection.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.mainInfo, for: indexPath)
            configureCell(cell, forNews: nil)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.projectNewsHeader, for: indexPath)
            configureCell(cell, forNews: nil)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.news, for: indexPath) as! NewsCell
            let news = newsCollection[indexPath.row]
            configureCell(cell, forNews: news)
        default:
            cell = UITableViewCell()
        }

        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forNews news: News?) {
        switch cell.reuseIdentifier {
        case TableViewCellIdentifiers.mainInfo:
            if let cell = cell as? ProjectCell,
                let project = project {
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
        case TableViewCellIdentifiers.news:
            if let cell = cell as? NewsCell,
                let news = news {
                cell.titleLabel.text = news.title
                cell.dateLabel.text = dateFormatter.string(from: news.date)
                cell.textView.text = news.text
                cell.likeButton.setTitle("\(news.likesCount)", for: .normal)
                cell.delegate = self
                cell.news = news
                if let currentUser = AuthService.instance.currentUser {
                    if let news = news as? OrganizationNews {
                        cell.isLiked = currentUser.isLikedNews(news, ofProject: nil)
                    } else if let news = news as? ProjectNews, let project = project {
                        cell.isLiked = currentUser.isLikedNews(news, ofProject: project)
                    }
                }
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.editProject {
            let navigationVC = segue.destination as! UINavigationController
            let configureProjectVC = navigationVC.topViewController as! ConfigureProjectVC
            configureProjectVC.project = project
        } else if segue.identifier == SegueIdentifiers.addProjectNews {
            let navigationVC = segue.destination as! UINavigationController
            let configureProjectNewsVC = navigationVC.topViewController as! ConfigureNewsVC
            configureProjectNewsVC.isOrganizationNews = false
            configureProjectNewsVC.project = project
        }
    }
}

extension ProjectDetailsVC: NewsCellDelegate {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidTapProjectNameButton(_ cell: UITableViewCell, onNews news: News) {
        
    }
}

extension ProjectDetailsVC: ProjectCellDelegate {
    func projectCellDidTapMoreButton(_ cell: ProjectCell, onProject project: Project) {
        
    }
    
    func projectCellDidSubscribe(_ cell: UITableViewCell, toProject project: Project) {
        
    }
    
    func projectCellDidUnsubscribe(_ cell: UITableViewCell, fromProject project: Project) {
        
    }
}

extension ProjectDetailsVC {
    struct TableViewCellIdentifiers {
        static let mainInfo = "MainInfoCell"
        static let projectNewsHeader = "ProjectNewsHeaderCell"
        static let news = "NewsCell"
    }
    struct SegueIdentifiers {
        static let addProjectNews = "AddProjectNews"
        static let editProject = "EditProject"
    }
}
