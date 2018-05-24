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
    
    var key: String?
    var title: String
    var text: String
    var date: Date
    var isCompleted: Bool
    var needMoney: Double
    var collectedMoney: Double
    var imageUrlsCollection: [String : String]
    var tagsCollection: [String]
    var newsCollection: [String: News]
    
    // MARK: - Computed properties
    
    var progress: Double {
        return collectedMoney / needMoney
    }
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, isCompleted: Bool, needMoney: Double, collectedMoney: Double = 0, imageUrlsCollection: [String : String] = [:], tagsCollection: [String] = [], newsCollection: [String: News] = [:]) {
        self.key = key
        self.title = title
        self.text = text
        self.date = date
        self.isCompleted = isCompleted
        self.needMoney = needMoney
        self.collectedMoney = collectedMoney
        self.imageUrlsCollection = imageUrlsCollection
        self.tagsCollection = tagsCollection
        self.newsCollection = newsCollection
    }
    
    // MARK: - SnapshotConvertible
    
    func convertToSnapshot() -> [String : Any] {
        let snapshot = [String: Any]()
        return snapshot
    }
}



