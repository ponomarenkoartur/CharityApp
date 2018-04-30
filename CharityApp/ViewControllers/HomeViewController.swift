//
//  ViewController.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UITableViewController {

    // MARK: - Properties
    
    var myFireDatabase: MyFireDatabase!
    var newsCollection = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let news1 = News(key: nil, title: "News1Title", text: "News1Text", date: Date(), likes: 34, imageUrlsCollection: nil, tagsCollection: nil)
        
        let news2 = News(key: nil, title: "News2Title", text: "News2Text", date: Date(), likes: 23, imageUrlsCollection: nil, tagsCollection: nil)
        
        newsCollection.append(contentsOf: [news1, news2])
        
        //myFireDatabase.getNewsFromOrganizationWithKey("Example", to: self)
        
        
        // Register Cells from a Nib
        let cellNib = UINib(nibName: TableViewCellIdenifiers.newsCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdenifiers.newsCell)
    }

    // MARK: - Actions
    
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        
    }
}

extension HomeViewController {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pieceOfNews = newsCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdenifiers.newsCell, for: indexPath) as! NewsCell
        configure(cell, for: pieceOfNews)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let news = newsCollection[indexPath.row]
//        let key = organization.info.name
//        myFireDatabase.deleteOrganizationWithKey(key)
    }
    
    func configure(_ cell: NewsCell, for news: News) {
        cell.titleLabel.text = news.title
        cell.dateLabel.text = dateFormatter.string(from: news.date)
    }
}

extension HomeViewController: IDatabaseResultListener {
    func onNewsListRetrieved(resultList: [String : News]) {
        newsCollection.removeAll()
        for item in resultList {
            newsCollection.append(item.value)
        }
        tableView.reloadData()
    }
    
    func onNeedsListRetrieved(resultList: [String : Need]) {
        
    }
    
    func onError() {
        
    }
}

extension HomeViewController {
    struct TableViewCellIdenifiers {
        static let newsCell = "NewsCell"
    }
}
