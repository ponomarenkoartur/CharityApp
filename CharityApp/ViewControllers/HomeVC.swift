
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
    
    var organization: Organization?
    var newsCollection = [OrganizationNews]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: TableViewCellIdentifiers.newsCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.newsCell)
        
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllOrganizationNews { (newsCollection) in
            self.newsCollection = newsCollection.sorted(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
        
        DataService.instance.getOrganization { (organization) in
            self.organization = organization
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdenifiers.addOrganizationNews {
            let navigationController = segue.destination as! UINavigationController
            let addNewsVC = navigationController.topViewController  as! ConfigureNewsVC
            addNewsVC.isOrganizationNews = true
        } else if segue.identifier == SegueIdenifiers.editNews {
            let cellSender = sender as! NewsCell
            let navigationController = segue.destination as! UINavigationController
            let newsDetailsVC = navigationController.topViewController as! ConfigureNewsVC
            newsDetailsVC.news = cellSender.news
        }
    }
}

extension HomeVC {
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return newsCollection.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.organizationInfo, for: indexPath) as! OrganizationInfoCell
            if let organization = organization {
                configureCell(cell, forOrganization: organization)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.organizationNewsLabel, for: indexPath)
            return cell
        } else if indexPath.section == 2 {
            let news = newsCollection[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.newsCell, for: indexPath) as! NewsCell
            configure(cell, for: news)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func configureCell(_ cell: OrganizationInfoCell, forOrganization organization: Organization) {
        cell.titleLabel.text = organization.name
        cell.descriptionTextView.text = organization.description
        cell.linkButton.setTitle(organization.contactInformation, for: .normal)
    }
    
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
        guard let organizationNews = news as? OrganizationNews,
            let currentUser = AuthService.instance.currentUser else {
            return
        }
    
        DataService.instance.likeNews(organizationNews, ofProject: nil, byUser: currentUser) { status in
            if status, let key = news.key {
                currentUser.likedOrganizationNewsKeys.append(key)
            }
        }
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        guard let organizationNews = news as? OrganizationNews,
            let currentUser = AuthService.instance.currentUser else {
            return
        }
        DataService.instance.unlikeNews(organizationNews, ofProject: nil, byUser: currentUser) { (status) in
            if status {
                for i in 0..<currentUser.likedOrganizationNewsKeys.count {
                    if currentUser.likedOrganizationNewsKeys[i] == organizationNews.key {
                        currentUser.likedOrganizationNewsKeys.remove(at: i)
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
    struct TableViewCellIdentifiers {
        static let newsCell = "NewsCell"
        static let organizationInfo = "OrganizationInfoCell"
        static let organizationNewsLabel = "OrganizationNewsLabel"
    }
    
    struct SegueIdenifiers {
        static let composeNews = "ComposeNews"
        static let editNews = "EditOrganizationNews"
        static let addOrganizationNews = "AddOrganizationNews"
    }
}
