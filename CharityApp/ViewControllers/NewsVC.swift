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
        
        let cellNib = UINib(nibName: TableViewCellIdentifiers.newsCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.newsCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataService.instance.getAllNews { (newsCollection) in
            self.newsCollection = newsCollection.sorted(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    // MARK: - TablewView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.newsCell, for: indexPath) as! NewsCell
        cell.configure(forNews: news)
        cell.delegate = self
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showProjectDetails {
            let cellSender = sender as! NewsCell
            let projectDetailsVC = segue.destination as! ProjectDetailsVC
            if let news = cellSender.news as? ProjectNews,
                let projectKey = news.parentProjectKey {
                DataService.instance.getProjectByKey(projectKey) { (project) in
                    projectDetailsVC.project = project
                }
            }
        }
    }
}

extension NewsVC {
    struct TableViewCellIdentifiers {
        static let newsCell = "NewsCell"
    }
    struct SegueIdentifiers {
        static let showProjectDetails = "ShowProjectDetails"
    }
}

