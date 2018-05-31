//
//  Need.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class Project: InfoItem, NewsCollectionContainer {
    
    // MARK: - Properties
    
    var isCompleted: Bool
    var needMoney: Double
    var collectedMoney: Double
    var newsCollection: [String: News]
    
    // MARK: - Computed properties
    
    var progress: Double {
        return collectedMoney / needMoney
    }
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, isCompleted: Bool, needMoney: Double, collectedMoney: Double = 0, imageUrlsCollection: [String : String] = [:], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = [], newsCollection: [String: News] = [:]) {
        self.isCompleted = isCompleted
        self.needMoney = needMoney
        self.collectedMoney = collectedMoney
        self.newsCollection = newsCollection
        super.init(key: key, title: title, text: text, date: date, imageUrlsCollection: imageUrlsCollection, videoUrlsCollection: videoUrlsCollection, tagsCollection: tagsCollection)
    }
    
    init(snapshot: DataSnapshot) {
        isCompleted = snapshot.childSnapshot(forPath: "completed").value as! Bool
        needMoney = snapshot.childSnapshot(forPath: "needMoney").value as! Double
        collectedMoney = snapshot.childSnapshot(forPath: "collectedMoney").value as! Double
        
        // TODO: Add getting imageUrls and videoUrls and news
        newsCollection = [:]
        
        var tags = [String]()
        if let tagsDict = snapshot.childSnapshot(forPath: "tags").value as? [String: String] {
            tags = Array(tagsDict.values)
        }
        
        super.init(key: snapshot.childSnapshot(forPath: "key").value as? String,
                   title: snapshot.childSnapshot(forPath: "title").value as! String,
                   text: snapshot.childSnapshot(forPath: "text").value as! String,
                   date: dateFormatter.date(from: snapshot.childSnapshot(forPath: "dateString").value as! String)!,
                   imageUrlsCollection: [:],
                   videoUrlsCollection: [:],
                   tagsCollection: tags)
    }
    
    // MARK: - SnapshotConvertible
    
    override func convertToSnapshot() -> [String : Any] {
        var snapshot = super.convertToSnapshot()
        snapshot["completed"] = isCompleted
        snapshot["needMoney"] = needMoney
        snapshot["collectedMoney"] = collectedMoney
        return snapshot
    }
}



