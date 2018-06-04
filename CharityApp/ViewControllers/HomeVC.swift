
//  ViewController.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UITableViewController {

    // MARK: - Properties
    
    var newsCollection = [OrganizationNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: TableViewCellIdenifiers.newsCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdenifiers.newsCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllOrganizationNews { (newsCollection) in
            self.newsCollection = newsCollection.sorted(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdenifiers.composeNews {
            let navigationController = segue.destination as! UINavigationController
            let addNewsVC = navigationController.topViewController  as! NewsDetailsVC
            addNewsVC.isOrganizationNews = true
        } else if segue.identifier == SegueIdenifiers.editNews {
            let cellSender = sender as! NewsCell
            let navigationController = segue.destination as! UINavigationController
            let newsDetailsVC = navigationController.topViewController as! NewsDetailsVC
            newsDetailsVC.news = cellSender.news
        }
    }
}

extension HomeVC {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdenifiers.newsCell, for: indexPath) as! NewsCell
        configure(cell, for: news)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func configure(_ cell: NewsCell, for news: OrganizationNews) {
        cell.titleLabel.text = news.title
        cell.dateLabel.text = dateFormatter.string(from: news.date)
        cell.textView.text = news.text
        cell.likeButton.setTitle("\(news.likesCount)", for: .normal)
        cell.delegate = self
        cell.news = news
        if let currentUser = AuthService.instance.currentUser {
            cell.isLiked = currentUser.isLikedNews(news, ofProject: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension HomeVC: NewsCellDelegate {
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News) {
        if let organizationNews = news as? OrganizationNews {
            DataService.instance.updateLikeCountOrganizationNews(organizationNews)
            if let currentUser = AuthService.instance.currentUser {
                DataService.instance.likeOrganizationNews(organizationNews, forUser: currentUser) { status in
                    if status, let key = news.key {
                        currentUser.likedOrganizationNewsKeys.append(key)
                    }
                }
            }
        }
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        if let organizationNews = news as? OrganizationNews {
            DataService.instance.updateLikeCountOrganizationNews(organizationNews)
            if let currentUser = AuthService.instance.currentUser {
                DataService.instance.unlikeOrganizationNews(organizationNews, forUser: currentUser) { (status) in
                    if status {
                        for i in 0..<currentUser.likedOrganizationNewsKeys.count {
                            if currentUser.likedOrganizationNewsKeys[i] == organizationNews.key {
                                currentUser.likedOrganizationNewsKeys.remove(at: i)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let moreInfoAction = UIAlertAction(title: "More Info", style: .default) { (_) in
            
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            self.performSegue(withIdentifier: SegueIdenifiers.editNews, sender: cell)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            let alert = UIAlertController(title: "Are you shure want to delete this news?", message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                if let organizationNews = news as? OrganizationNews {
                    DataService.instance.removeOrganizationNews(organizationNews, deleteComplete: { (status) in
                        if status {
                            let index = self.newsCollection.index(of: organizationNews)
                            if let index = index {
                                self.newsCollection.remove(at: index)
                                self.tableView.reloadData()
                            }
                            // TODO: Add notification that deletion completed
                        } else {
                            // TODO: Add notification that deletion can't be completed
                        }
                    })
                }
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

extension HomeVC {
    struct TableViewCellIdenifiers {
        static let newsCell = "NewsCell"
    }
    
    struct SegueIdenifiers {
        static let composeNews = "ComposeNews"
        static let editNews = "EditOrganizationNews"
    }
}
