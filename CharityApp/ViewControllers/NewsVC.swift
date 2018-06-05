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
            print(newsCollection.count)
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
        }
        if let currentUser = AuthService.instance.currentUser {
            cell.isLiked = currentUser.isLikedNews(news, ofProject: nil)
        }
    }
}

extension NewsVC: NewsCellDelegate {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        
    }
}

extension NewsVC {
    struct TableViewCellIdentifiers {
        static let newsCell = "NewsCell"
    }
}

