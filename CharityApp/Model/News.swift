//
//  News.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation
import Firebase

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd HH:mm"
    return formatter
}()

class News: InfoItem {
    
    // MARK: - Properties
    
    var key: String?
    
    // MARK: - Initialization
    
    override init(title: String, text: String, date: Date, imageUrlsCollection: [String: String]?, tagsCollection: [String: String]?) {
        super.init(title: title, text: text, date: date, imageUrlsCollection: imageUrlsCollection, tagsCollection: tagsCollection)
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        
        key = snapshotValue["newsKey"] as? String
        
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
