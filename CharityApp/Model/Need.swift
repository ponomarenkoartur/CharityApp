//
//  Need.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

//class Need: NewsCollectionContainer {

//    // MARK: - Properties
//
//    var isCompleted: Bool
//    var newsCollection: [String: News]?
//
//    // MARK: - Initialization
//
//    init(key: String?, title: String, text: String, date: Date, likes: Int, imageUrlsCollection: [String: String]?, tagsCollection: [String: String]?, newsCollection: [String: News]?, isCompleted: Bool) {
//        self.isCompleted = isCompleted
//        self.newsCollection = newsCollection
//        super.init(key: key, title: title, text: text, date: date, likes: likes, imageUrlsCollection: imageUrlsCollection, tagsCollection: tagsCollection)
//    }
//
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: Any]
//
//        isCompleted = snapshotValue["completed"] as! Bool
//
//        newsCollection = [String: News]()
//        for news in snapshot.childSnapshot(forPath: "organizationNews").children {
//            let newNews = News(snapshot: news as! DataSnapshot)
//            newsCollection![newNews.key!] = newNews
//        }
//
//        let dateString = snapshotValue["dateString"] as! String
//        let date = dateFormatter.date(from: dateString)!
//
//
//        super.init(key: snapshotValue["charityNeedKey"] as? String,
//                   title: snapshotValue["title"] as! String,
//                   text: snapshotValue["text"] as! String,
//                   date: date,
//                   likes: snapshotValue["likes"] as! Int,
//                   imageUrlsCollection: snapshotValue["imageUrls"] as? [String: String],
//                   tagsCollection: snapshotValue["tags"] as? [String: String])
//    }
    

//}


