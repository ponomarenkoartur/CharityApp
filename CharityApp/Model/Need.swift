//
//  Need.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class Need: InfoItem, NewsCollectionContainer {
    
    // MARK: - Properties
    
    var key: String?
    var isCompleted: Bool
    var newsCollection: [String: News]?
    
    // MARK: - Initialization
    
    init(title: String, text: String, isCompleted: Bool, likes: Int, date: Date, imageUrlsCollection: [String: String]?, tagsCollection: [String: String]?, newsCollection: [String: News]?) {
        self.isCompleted = isCompleted
        self.newsCollection = newsCollection
        super.init(title: title, text: text, date: date, imageUrlsCollection: imageUrlsCollection, tagsCollection: tagsCollection)
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        
        key = snapshotValue["charityNeedKey"] as? String
        isCompleted = snapshotValue["completed"] as! Bool
        
        newsCollection = [String: News]()
        for news in snapshot.childSnapshot(forPath: "organizationNews").children {
            let newNews = News(snapshot: news as! DataSnapshot)
            newsCollection![newNews.key!] = newNews
        }
        
        let dateString = snapshotValue["dateString"] as! String
        let date = dateFormatter.date(from: dateString)!
        
        super.init(title: snapshotValue["title"] as! String,
                   text: snapshotValue["text"] as! String,
                   date: date,
                   imageUrlsCollection: snapshotValue["imageUrls"] as? [String: String],
                   tagsCollection: snapshotValue["tags"] as? [String: String])
    }
    
    // MARK: - Methods
    
    /// This will make all list variables null for correct saving into database.
    
    func dropAllListData() {
        imageUrlsCollection = nil
        tagsCollection = nil
        newsCollection = nil
    }
    
    // MARK: - ConvertibleToDictionary
    
    override func convertingPrimitivePropertiesToDictionary() -> [String : Any] {
        var dict = super.convertingPrimitivePropertiesToDictionary()
        dict["key"] = key!
        dict["completed"] = isCompleted
        return dict
    }
}


