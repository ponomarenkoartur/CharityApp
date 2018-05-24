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
    
    // MARK: - SnapshotConvertible
    
    override func convertToSnapshot() -> [String : Any] {
        var snapshot = super.convertToSnapshot()
        snapshot["completed"] = isCompleted
        snapshot["needMoney"] = needMoney
        snapshot["collectedMoney"] = collectedMoney
        return snapshot
    }
}



