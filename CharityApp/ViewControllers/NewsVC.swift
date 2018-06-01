//
//  ViewController.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
import Firebase

class NewsVC: UITableViewController {

    // MARK: - Properties
    
    var newsCollection = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.getAllOrganizationNews { (newsCollection) in
            self.newsCollection = newsCollection.sorted(by: { $0.date > $1.date })
            self.tableView.reloadData()
        }
    }

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeNews" {
            let addNewsVC = segue.destination as! NewsDetailsVC
            addNewsVC.isOrganizationNews = true
        }
    }
}

extension NewsVC {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = newsCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdenifiers.newsCell, for: indexPath) as! OrganizationNewsCell
        configure(cell, for: news)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func configure(_ cell: OrganizationNewsCell, for news: News) {
        cell.titleLabel.text = news.title
        cell.dateLabel.text = dateFormatter.string(from: news.date)
        cell.textView.text = news.text
        cell.likeButton.setTitle(String(news.likesCount), for: .normal)
        cell.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension NewsVC: OrganizationNewsCellDelegate {
    func organizationNewsCellDelegateDidTapMoreButton(_ cell: UITableViewCell) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let moreInfoAction = UIAlertAction(title: "More Info", style: .default) { (_) in
            
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { (_) in
            
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            let alert = UIAlertController(title: "Are you shure want to delete this news?", message: nil, preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                // TODO: Delete news
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

extension NewsVC {
    struct TableViewCellIdenifiers {
        static let newsCell = "OrganizationNewsCell"
    }
}
