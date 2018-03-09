//
//  Organization.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class Organization: NewsCollectionContainer {
    
    // MARK: - Properties
    
    var info: OrganizationInfo
    var newsCollection: [String: News]?
    var needsCollection: [String: Need]?
    
    // MARK: - Initialization
    
    init(info: OrganizationInfo) {
        self.info = info
    }
    
    init(info: OrganizationInfo, newsCollection: [String: News]?, needsCollection: [String: Need]?) {
        self.info = info
        self.newsCollection = newsCollection
        self.needsCollection = needsCollection
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        
        let infoSnapshotValue = snapshotValue["organizationInfo"] as! [String: String]
        info = OrganizationInfo(
            name: infoSnapshotValue["name"]!,
            description: infoSnapshotValue["description"]!,
            contactInformation: infoSnapshotValue["contactInformation"]!,
            defaultAccountNumber: infoSnapshotValue["defaultAccountNumber"]!)
        
        newsCollection = [String: News]()
        for news in snapshot.childSnapshot(forPath: "organizationNews").children {
            let newNews = News(snapshot: news as! DataSnapshot)
            newsCollection![newNews.key!] = newNews
        }
        
        needsCollection = [String: Need]()
        for need in snapshot.childSnapshot(forPath: "charityNeeds").children {
            let newNeed = Need(snapshot: need as! DataSnapshot)
            needsCollection![newNeed.key!] = newNeed
        }
        
    }
    
    // MARK: - Methods
    
    /// This will make all list variables null for correct saving into database.
    func dropAllLists() {
        newsCollection = nil
        needsCollection = nil
    }
}
