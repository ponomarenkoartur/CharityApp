//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase
import Foundation

class InfoItem: ImageContentContainer {
    
    // MARK: - Properties

    var title: String
    var text: String
    var likes: Int
    var date: Date
    var imageURLs: [String : String]?
    
    // MARK: - Initialization
    
    init(title: String, text: String, date:
        Date, imageURLs: [String : String]?) {
        self.title = title
        self.text = text
        self.date = date
        if let imageURLs = imageURLs {
            self.imageURLs = imageURLs
        }
        likes = 0
    }
    
    // MARK: - ConvertibleToDictionaty
    
    func primitivePropertiesToDictionary() -> [String : Any] {
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
