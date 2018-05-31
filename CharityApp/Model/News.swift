//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//
import Firebase

class News: InfoItem {
    
    // MARK: - Properties
    
    var likesCount: Int
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, likesCount: Int = 0, imageUrlsCollection: [String : String] = [:], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = []) {
        self.likesCount = likesCount
        super.init(key: key, title: title, text: text, date: date, imageUrlsCollection: imageUrlsCollection, videoUrlsCollection: videoUrlsCollection, tagsCollection: tagsCollection)
    }
    
    override init(snapshot: DataSnapshot) {
        likesCount = snapshot.childSnapshot(forPath: "likes").value as! Int
        super.init(snapshot: snapshot)
    }
    
    // MARK: - SnapshotConvertible
    
    override func convertToSnapshot() -> [String: Any] {
        var snapshot = super.convertToSnapshot()
        snapshot["likes"] = likesCount
        return snapshot
    }
}
