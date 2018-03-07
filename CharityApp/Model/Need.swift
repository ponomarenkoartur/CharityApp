//
//  Need.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class Need: InfoItem, NewsContainer {
    
    // MARK: - Properties
    
    var key: String?
    var isCompleted: Bool
    var tags: [String: String]?
    var news: [String: News]?
    
    // MARK: - Initialization
    
    init(title: String, text: String, isCompleted: Bool, likes: Int, date: Date, imageURLs: [String: String]?, tags: [String: String]?, news: [String: News]?) {
        self.isCompleted = isCompleted
        if let tags = tags {
            self.tags = tags
        }
        if let news = news {
            self.news = news
        }
        super.init(title: title, text: text, date: date, imageURLs: imageURLs)
    }
    
    // MARK: - Methods
    
    /// This will make all list variables null for correct saving into database.
    
    func dropAllListData() {
        imageURLs = nil
        tags = nil
        news = nil
    }
    
    // MARK: - ConvertibleToDictionary
    
    override func primitivePropertiesToDictionary() -> [String : Any] {
        var dict = super.primitivePropertiesToDictionary()
        dict["key"] = key!
        dict["completed"] = isCompleted
        return dict
    }
}


