//
//  NewsVC.swift
//  CharityApp
//
//  Created by Artur on 6/1/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NewsVC: UITableViewController {

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
    }
    
    // MARK: - TablewView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.newsCell, for: indexPath) as! NewsCell
        configureCell(cell, forNews: news)
        return cell
    }
    
    func configureCell(_ cell: NewsCell, forNews news: News) {
        cell.titleLabel.text = news.title
        cell.dateLabel.text = dateFormatter.string(from: news.date)
        cell.textView.text = news.text
        cell.likeButton.setTitle("\(news.likesCount)", for: .normal)
        cell.delegate = self
        cell.news = news
        if let news = news as? ProjectNews,
            let projectKey = news.parentProjectKey {
            DataService.instance.getProjectByKey(projectKey) { (project) in
                cell.project = project
                
            }
            if let currentUser = AuthService.instance.currentUser {
                cell.isLiked = currentUser.isLikedNews(news, ofProjectWithKey: news.parentProjectKey)
            }
        } else {
            if let currentUser = AuthService.instance.currentUser {
                cell.isLiked = currentUser.isLikedNews(news, ofProject: nil)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showProjectDetails {
            let cellSender = sender as! NewsCell
            let projectDetailsVC = segue.destination as! ProjectDetailsVC
            projectDetailsVC.project = cellSender.project
        }
    }
}

extension NewsVC: NewsCellDelegate {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News) {
        guard let currentUser = AuthService.instance.currentUser else {
                return
        }
        if let news = news as? ProjectNews,
            let projectKey = news.parentProjectKey {
            DataService.instance.likeNews(news, ofProjectWithKey: projectKey, byUser: currentUser) { status in
                if status,
                    let newsKey = news.key,
                    let projectKey = news.parentProjectKey {
                    if currentUser.likedProjectNewsKeys.keys.contains(projectKey) {
                        currentUser.likedProjectNewsKeys[projectKey]!.append(newsKey)
                    } else {
                        currentUser.likedProjectNewsKeys[projectKey] = []
                        currentUser.likedProjectNewsKeys[projectKey]!.append(newsKey)
                    }
                }
            }
        } else if let news = news as? OrganizationNews {
            DataService.instance.likeNews(news, ofProject: nil, byUser: currentUser) { status in
                if status, let newsKey = news.key {
                    currentUser.likedOrganizationNewsKeys.append(newsKey)
                }
            }
        }
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        guard let currentUser = AuthService.instance.currentUser else {
            return
        }
        
        if let news = news as? ProjectNews,
            let projectKey = news.parentProjectKey {
            
            DataService.instance.unlikeNews(news, ofProjectWithKey: projectKey, byUser: currentUser) { (status) in
                print(status)
            }
        } else if let news = news as? OrganizationNews {
            DataService.instance.unlikeNews(news, ofProject: nil, byUser: currentUser) { (status) in
                if status {
                    for i in 0..<currentUser.likedOrganizationNewsKeys.count {
                        if currentUser.likedOrganizationNewsKeys[i] == news.key {
                            currentUser.likedOrganizationNewsKeys.remove(at: i)
                        }
                    }
                }
            }
        }
    }
    
    func newsCellDidTapProjectNameButton(_ cell: UITableViewCell, onNews news: News, ofProject project: Project) {
        performSegue(withIdentifier: SegueIdentifiers.showProjectDetails, sender: cell)
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

