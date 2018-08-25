//
//  ProjNews.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class ProjNews: News {
    
    var parentProjectKey: String?
    var parentProjectTitle: String?
    
    init(key: String?, title: String, text: String, parentProjectKey: String?, parentProjectTitle: String?, date: Date = Date(), likesCount: Int = 0, imageUrlsCollection: [String] = [], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = []) {
        self.parentProjectKey = parentProjectKey
        self.parentProjectTitle = parentProjectTitle
        super.init(key: key, title: title, text: text, date: date, likesCount: likesCount, imageUrlsCollection: imageUrlsCollection, videoUrlsCollection: videoUrlsCollection, tagsCollection: tagsCollection)
    }
    
    override init(snapshot: DataSnapshot) {
        super.init(snapshot: snapshot)
    }
    
    // MARK: SnapshotConvertible
    
    override func convertToSnapshot() -> [String: Any] {
        var snapshot = super.convertToSnapshot()
        snapshot["organizationNews"] = false
        return snapshot
    }
}
