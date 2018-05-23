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
    
    var newsCollection = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        cell.setLikeCounterLabelText(to: String(news.likesCount))
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension NewsViewController {
    struct TableViewCellIdenifiers {
        static let newsCell = "NewsCell"
    }
}
