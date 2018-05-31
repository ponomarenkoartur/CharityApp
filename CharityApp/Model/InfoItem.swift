//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class InfoItem: ImageContentCollectionContainer, VideoContentCollectionContainer, SnapshotConvertible {
    
    // MARK: - Properties
    
    var key: String?
    var title: String
    var text: String
    let date: Date
    var imageUrlsCollection: [String : String]
    var videoUrlsCollection: [String : String]
    var tagsCollection: [String]
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, imageUrlsCollection: [String : String] = [:], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = []) {
        self.key = key
        self.title = title
        self.text = text
        self.date = date
        self.imageUrlsCollection = imageUrlsCollection
        self.videoUrlsCollection = videoUrlsCollection
        self.tagsCollection = tagsCollection
    }
    
    init(snapshot: DataSnapshot) {
        // TODO: Add getting imageUrls and videoUrls
        var tags = [String]()
        if let tagsDict = snapshot.childSnapshot(forPath: "tags").value as? [String: String] {
            tags = Array(tagsDict.values)
        }
        
        key =  snapshot.childSnapshot(forPath: "key").value as? String
        title = snapshot.childSnapshot(forPath: "title").value as! String
        text = snapshot.childSnapshot(forPath: "text").value as! String
        date = dateFormatter.date(from: snapshot.childSnapshot(forPath: "dateString").value as! String)!
        imageUrlsCollection = [:]
        videoUrlsCollection = [:]
        tagsCollection = tags
    }
    
    // MARK: - SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        var snapshot = [String: Any]()
        if let key = key {
            snapshot["key"] = key
        }
        snapshot["title"] = title
        snapshot["text"] = text
        snapshot["dateString"] = dateFormatter.string(from: date)
        snapshot["tags"] = Dictionary(grouping: tagsCollection, by: { $0 })
        return snapshot
    }
}
