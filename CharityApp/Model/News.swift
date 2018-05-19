//
//  News.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation
import Firebase

class News: InfoItem {
    
    // MARK: - Initialization
    
    convenience init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        
        let dateString = snapshotValue["dateString"] as! String
        let date = dateFormatter.date(from: dateString)!
        
        self.init(key: snapshotValue["newsKey"] as? String,
                  title: snapshotValue["title"] as! String,
                  text: snapshotValue["text"] as! String,
                  date: date,
                  likes: snapshotValue["likes"] as! Int,
                  imageUrlsCollection: snapshotValue["imageUrls"] as? [String: String],
                  tagsCollection: snapshotValue["tags"] as? [String: String])
    }
    
    // MARK: - Methods
    
    /// This will make all list variables null for correct saving into database.
    func dropImageURLs() {
        imageUrlsCollection = nil
    }
    
    // MARK: - ConvertibleToDictionaty
    override func convertingPrimitivePropertiesToDictionary() -> [String : Any] {
        var dict = super.convertingPrimitivePropertiesToDictionary()
        dict["key"] = key!
        return dict
    }
}
