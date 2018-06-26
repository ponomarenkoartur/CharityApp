//
//  NewsVC.swift
//  CharityApp
//
//  Created by Artur on 6/1/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NewsVC: NewsCellContainerTableVC {

    // MARK: - Properties
    
    var newsCollection = [News]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.organizationNewsCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.organizationNewsCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.projectNewsCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.projectNewsCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataService.instance.getAllNews { (newsCollection) in
            self.newsCollection = newsCollection.sorted(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func addNewsButtonWasTapped(_ sender: UIBarButtonItem) {
        let homeTabStoryboard = UIStoryboard(name: "HomeTab", bundle: nil)
        let navigationVC = homeTabStoryboard.instantiateViewController(withIdentifier: "ConfigureNewsNavigationVC") as! UINavigationController
        let addNewsVC = navigationVC.viewControllers.first as! ConfigureNewsVC
        show(navigationVC, sender: nil)
    }
    
    // MARK: - TablewView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsCollection[indexPath.row]
        var cell: NewsCell
        if news is ProjectNews {
            cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.projectNewsCell, for: indexPath) as! ProjectNewsCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.organizationNewsCell, for: indexPath) as! OrganizationNewsCell
        }
        cell.configure(forNews: news)
        cell.delegate = self
        return cell
    }
    
}

extension NewsVC {
    func newsCellDidTapProjectNameButton(_ cell: UITableViewCell, onNews news: ProjectNews) {
        let projectTabStoryBoard = UIStoryboard(name: "ProjectsTab", bundle: nil)
        let projectDetailsVC = projectTabStoryBoard.instantiateViewController(withIdentifier: "ProjectDetailsVC") as! ProjectDetailsVC
        
        if let newsCell = cell as? NewsCell,
            let news = newsCell.news as? ProjectNews,
            let projectKey = news.parentProjectKey {
            DataService.instance.getProjectByKey(projectKey) { (project) in
                projectDetailsVC.project = project
                self.show(projectDetailsVC, sender: nil)
            }
        }
        
    }
}

extension NewsVC {
    struct TableViewCellIdentifiers {
        static let organizationNewsCell = "OrganizationNewsCell"
        static let projectNewsCell = "ProjectNewsCell"
    }
    struct SegueIdentifiers {
        static let showProjectDetails = "ShowProjectDetails"
    }
}

