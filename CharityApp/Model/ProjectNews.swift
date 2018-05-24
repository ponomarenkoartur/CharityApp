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
    
    var parentNeedKey: String?
    var parentNeedTitle: String?
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, likesCount: Int = 0, imageUrlsCollection: [String : String] = [:], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = [], parentNeedKey: String?, parentNeedTitle: String?) {
        self.parentNeedKey = parentNeedKey
        self.parentNeedTitle = parentNeedTitle
        super.init(key: key, title: title, text: text, date: date, likesCount: likesCount, imageUrlsCollection: imageUrlsCollection, videoUrlsCollection: videoUrlsCollection, tagsCollection: tagsCollection)
    }
    
    // MARK: SnapshotConvertible
    
    override func convertToSnapshot() -> [String: Any] {
        var snapshot = super.convertToSnapshot()
        snapshot["organizationNews"] = true
        snapshot["parentNeedKey"] = parentNeedKey
        snapshot["parentNeedTitle"] = parentNeedTitle
        return snapshot
    }
}
