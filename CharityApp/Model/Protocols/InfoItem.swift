//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

class InfoItem: ImageContentCollectionContainer, VideoContentCollectionContainer, SnapshotConvertible {
    
    // MARK: - Properties
    
    var key: String?
    var title: String
    var text: String
    var date: Date
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
    
    // MARK: - SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        var snapshot = [String: Any]()
        if let key = key {
            snapshot["newsKey"] = key
        }
        snapshot["title"] = title
        snapshot["text"] = text
        snapshot["dateString"] = dateFormatter.string(from: date)
        snapshot["tags"] = Dictionary(grouping: tagsCollection, by: { $0 })
        return snapshot
    }
}
