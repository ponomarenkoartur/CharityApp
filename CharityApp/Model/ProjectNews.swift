//
//  ProjectNews.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

class ProjectNews: News {
    
    // MARK: - Properties
    
    var key: String?
    var title: String
    var text: String
    var likesCount: Int
    var date: Date
    var imageUrlsCollection: [String : String]
    var tagsCollection: [String]
    var parentNeedKey: String?
    var parentNeedTitle: String?
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, likes: Int = 0, imageUrlsCollection: [String : String] = [:], tagsCollection: [String] = [], parentNeedKey: String?, parentNeedTitle: String?) {
        self.key = key
        self.title = title
        self.text = text
        self.date = date
        self.likesCount = likes
        self.imageUrlsCollection = imageUrlsCollection
        self.tagsCollection = tagsCollection
        self.parentNeedKey = parentNeedKey
        self.parentNeedTitle = parentNeedTitle
    }
    
    // MARK: SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        var snapshot = [String: Any]()
        return snapshot
    }
}
