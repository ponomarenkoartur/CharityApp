//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class InfoItem: NSObject, ImageContentCollectionContainer, VideoContentCollectionContainer, SnapshotConvertible {
    
    // MARK: - Properties
    
    var key: String?
    var title: String
    var text: String
    let date: Date
    var imageUrlsCollection: [String]
    var videoUrlsCollection: [String : String]
    var tagsCollection: [String]
    
    // MARK: - Initialization
    
    init(key: String?, title: String, text: String, date:
        Date, imageUrlsCollection: [String] = [], videoUrlsCollection: [String : String] = [:], tagsCollection: [String] = []) {
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
        title = snapshot.childSnapshot(forPath: "title").value as! String
        text = snapshot.childSnapshot(forPath: "text").value as! String
        date = dateFormatter.date(from: snapshot.childSnapshot(forPath: "dateString").value as! String)!
        imageUrlsCollection = []
        for imageUrlSnapshot in snapshot.childSnapshot(forPath: "imageUrls").children {
            guard let imageUrlSnapshot = imageUrlSnapshot as? DataSnapshot else {
                break
            }
                let imageUrlString = imageUrlSnapshot.value as! String
                imageUrlsCollection.append(imageUrlString)
            
        }
        videoUrlsCollection = [:]
        tagsCollection = tags
    }
    
    // MARK: - SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        var snapshot = [String: Any]()
        snapshot["title"] = title
        snapshot["text"] = text
        snapshot["dateString"] = dateFormatter.string(from: date)
        snapshot["tags"] = Dictionary(grouping: tagsCollection, by: { $0 })
        return snapshot
    }
}
