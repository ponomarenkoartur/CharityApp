//
//  ViewController.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
import Firebase

class NewsViewController: UITableViewController {

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

extension NewsViewController {
    
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
        return 400
    }
    
    func configure(_ cell: NewsCell, for news: News) {
        cell.titleLabel.text = news.title
        cell.dateLabel.text = dateFormatter.string(from: news.date)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension NewsViewController: IDatabaseResultListener {
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

extension NewsViewController {
    struct TableViewCellIdenifiers {
        static let newsCell = "NewsCell"
    }
}
