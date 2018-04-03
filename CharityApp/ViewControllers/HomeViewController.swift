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
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFireDatabase.getNewsFromOrganizationWithKey("Example", to: self)
        
        if let url = URL(string: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png") {
//            downloadImage(url: url)
        }
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
        let news = newsCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.titleLabel.text = news.title
        cell.dateLabel.text = dateFormatter.string(from: news.date)
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
