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
    var newsCollection: [News]
    
    // MARK: - Computed properties
    
    var progress: Double {
        return collectedMoney / needMoney
    }
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, isCompleted: Bool, needMoney: Double, collectedMoney: Double = 0, imageUrlsCollection: [String] = [], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = [], newsCollection: [News] = []) {
        self.isCompleted = isCompleted
        self.needMoney = needMoney
        self.collectedMoney = collectedMoney
        self.newsCollection = newsCollection
        super.init(key: key, title: title, text: text, date: date, imageUrlsCollection: imageUrlsCollection, videoUrlsCollection: videoUrlsCollection, tagsCollection: tagsCollection)
    }
    
    override init(snapshot: DataSnapshot) {
        isCompleted = snapshot.childSnapshot(forPath: "completed").value as! Bool
        needMoney = snapshot.childSnapshot(forPath: "needMoney").value as! Double
        collectedMoney = snapshot.childSnapshot(forPath: "collectedMoney").value as! Double
        
        newsCollection = []
        super.init(snapshot: snapshot)
        key = snapshot.childSnapshot(forPath: "charityNeedKey").value as? String
    }
    
    // MARK: - SnapshotConvertible
    
    override func convertToSnapshot() -> [String : Any] {
        var snapshot = super.convertToSnapshot()
        if let key = key {
            snapshot["charityNeedKey"] = key
        }
        snapshot["completed"] = isCompleted
        snapshot["needMoney"] = needMoney
        snapshot["collectedMoney"] = collectedMoney
        return snapshot
    }
}



