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
    
    override init(title: String, text: String, date: Date, imageURLs: [String: String]?) {
        super.init(title: title, text: text, date: date, imageURLs: imageURLs)
    }
    
    // MARK: - Methods
    
    /// This will make all list variables null for correct saving into database.
    func dropImageURLs() {
        imageURLs = nil
    }
    
    // MARK: -
    
    override func primitivePropertiesToDictionary() -> [String : Any] {
        var dict = super.primitivePropertiesToDictionary()
        dict["key"] = key!
        return dict
    }
}

extension News {
    
}
