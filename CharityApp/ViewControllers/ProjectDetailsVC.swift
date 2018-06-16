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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.image, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.image)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.news, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.news)
        
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let project = project else { return }
        DataService.instance.getAllNewsOfProject(project) { (newsCollection) in
            project.newsCollection = newsCollection.sorted(by: { $0.date > $1.date })
            let indexSet = IndexSet(integer: 3)
            self.tableView.reloadSections(indexSet as IndexSet, with: .fade)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let project = project else { return 0 }
        switch section {
        case 0, 2:
            return 1
        case 1:
            print(project.imageUrlsCollection.count)
            return project.imageUrlsCollection.count
        case 3:
            return project.newsCollection.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let project = project else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.mainInfo, for: indexPath) as! ProjectCell
            cell.configureForProject(project)
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.image, for: indexPath) as! ImageCell
            let imageUrlString = project.imageUrlsCollection[indexPath.row]
            cell.configure(forUrlString: imageUrlString)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.projectNewsHeader, for: indexPath)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.news, for: indexPath) as! NewsCell
            let news = project.newsCollection[indexPath.row]
            cell.configureForNews(news)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
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
            configureProjectNewsVC.project = project
        }
    }
}

extension ProjectDetailsVC: NewsCellDelegate {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News) {
        guard let projectNews = news as? ProjectNews,
            let project = project,
            let currentUser = AuthService.instance.currentUser else {
                return
        }
        
        DataService.instance.likeNews(projectNews, ofProject: project, byUser: currentUser) { status in
            if status,
                let newsKey = news.key,
                let projectKey = project.key {
                if currentUser.likedProjectNewsKeys.keys.contains(projectKey) {
                   currentUser.likedProjectNewsKeys[projectKey]!.append(newsKey)
                } else {
                   currentUser.likedProjectNewsKeys[projectKey] = []
                    currentUser.likedProjectNewsKeys[projectKey]!.append(newsKey)
                }
            }
        }
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        guard let projectNews = news as? ProjectNews,
            let project = project,
            let currentUser = AuthService.instance.currentUser else {
                return
        }
        
        DataService.instance.unlikeNews(projectNews, ofProject: project, byUser: currentUser) { (status) in
            print(status)
        }
        
    }
    
    func newsCellDidTapProjectNameButton(_ cell: UITableViewCell, onNews news: News) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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
        static let image = "ImageCell"
    }
    struct SegueIdentifiers {
        static let addProjectNews = "AddProjectNews"
        static let editProject = "EditProject"
    }
}
