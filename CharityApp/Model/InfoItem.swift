//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase
import Foundation

class InfoItem: ImageContentCollectionContainer {
    
    // MARK: - Properties

    var key: String?
    var title: String
    var text: String
    var likes: Int
    var date: Date
    var imageUrlsCollection: [String : String]?
    var tagsCollection: [String: String]?
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, likes: Int, imageUrlsCollection: [String : String]?, tagsCollection: [String: String]?) {
        self.key = key
        self.title = title
        self.text = text
        self.date = date
        self.likes = likes
        self.imageUrlsCollection = imageUrlsCollection
        self.tagsCollection = tagsCollection
    }
    
    // MARK: - ConvertibleToDictionaty
    
    func convertingPrimitivePropertiesToDictionary() -> [String : Any] {
        let dateString = dateFormatter.string(from: date)
        let dict: [String : Any] = [
            "title": title,
            "text": text,
            "likes": likes,
            "dateString": dateString
        ]
        return dict
    }
}
