//
//  OrganizationNews.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

class OrganizationNews: News {
    
    // MARK: - Properties
    
    var key: String?
    var title: String
    var text: String
    var likesCount: Int
    var date: Date
    var imageUrlsCollection: [String : String]
    var tagsCollection: [String]
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, likes: Int = 0, imageUrlsCollection: [String : String] = [:], tagsCollection: [String] = []) {
        self.key = key
        self.title = title
        self.text = text
        self.date = date
        self.likesCount = likes
        self.imageUrlsCollection = imageUrlsCollection
        self.tagsCollection = tagsCollection
    }
    
    // MARK: SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        var snapshot = [String: Any]()
        snapshot["organizationNews"] = true
        if let key = key {
            snapshot["newsKey"] = key
        }
        snapshot["title"] = title
        snapshot["text"] = text
        snapshot["likes"] = likesCount
        snapshot["dateString"] = dateFormatter.string(from: date)
        return snapshot
    }
}
