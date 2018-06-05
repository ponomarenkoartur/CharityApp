//
//  User.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class User: SnapshotConvertible {
    
    // MARK: - Properties
    
    var key: String?
    let email: String
    let accountCreationDate: Date
    var isAdmin: Bool
    var likedProjectNewsKeys: [String: [String]]
    var likedOrganizationNewsKeys: [String]
    var subcribedProjectsKeys: [String]
    
    // MARK: - Initialization
    
    init(key: String?, email: String, accountCreationDate: Date = Date(), isAdmin: Bool = false, likedNewsKeys: [String: [String]] = [:], likedOrganizationNewsKeys: [String] = [], subcribedProjectsKeys: [String] = []) {
        self.key = key
        self.email = email
        self.accountCreationDate = accountCreationDate
        self.isAdmin = isAdmin
        self.likedProjectNewsKeys = likedNewsKeys
        self.likedOrganizationNewsKeys = likedOrganizationNewsKeys
        self.subcribedProjectsKeys = subcribedProjectsKeys
    }
    
    init(snapshot: DataSnapshot) {
        print(snapshot)
        key = snapshot.key as String
        email = snapshot.childSnapshot(forPath: "email").value as! String
        accountCreationDate = dateFormatter.date(from: snapshot.childSnapshot(forPath: "accountCreationDate").value as! String)!
        isAdmin = snapshot.childSnapshot(forPath: "admin").value as! Bool
        
        likedProjectNewsKeys = [:]
        for likedProjectNews in snapshot.childSnapshot(forPath: "likedNewsPosts").children {
            if let likedProjectNews = likedProjectNews as? DataSnapshot {
                let projectName = likedProjectNews.key
                var likedProjectNewsString = likedProjectNews.value as! String
                
                // Delete last comma
                likedProjectNewsString.removeLast()

                likedProjectNewsKeys[projectName] = []
                likedProjectNewsKeys[likedProjectNews.key] = likedProjectNewsString.split { $0 == "," }.map(String.init)
            }
        }
        
        if let likedOrganizationNewsKeysString = snapshot.childSnapshot(forPath: "likedOrganizationNews").value as? String {
            // Delete last comma
            var likedOrganizationNewsKeysCorrectString = likedOrganizationNewsKeysString
            likedOrganizationNewsKeysCorrectString.removeLast()
            
                likedOrganizationNewsKeys = likedOrganizationNewsKeysCorrectString.split { $0 == "," }.map(String.init)
        } else {
            likedOrganizationNewsKeys = []
        }
        
        if let subcribedProjectsKeysString = snapshot.childSnapshot(forPath: "subcribedNeeds").value as? String {
            // Delete last comma
            var subcribedProjectsKeysCorrectString = subcribedProjectsKeysString
            subcribedProjectsKeysCorrectString.removeLast()
            
            subcribedProjectsKeys = subcribedProjectsKeysCorrectString.split { $0 == "," }.map(String.init)
        } else {
            subcribedProjectsKeys = []
        }
    }
    
    // MARK: - Methods
    
    func isLikedNews(_ news: News, ofProjectWithKey projectKey: String?) -> Bool {
        guard let newsKey = news.key else {
            return false
        }
        if let _ = news as? OrganizationNews {
            return likedOrganizationNewsKeys.contains(newsKey)
        } else if let _ = news as? ProjectNews,
            let projectKey = projectKey,
            let likedNewsOfProjectString = likedProjectNewsKeys[projectKey] {
            return likedNewsOfProjectString.contains(newsKey)
        } else {
            return false
        }
    }
    
    func isLikedNews(_ news: News, ofProject project: Project?) -> Bool {
        return isLikedNews(news, ofProjectWithKey: project?.key)
    }
    
    func isSubscribedProject(_ project: Project) -> Bool {
        guard let key = project.key else {
            return false
        }
        return subcribedProjectsKeys.contains(key)
    }
    
    // MARK: - SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        let snapshot: [String: Any] = [
            "email": email,
            "accountCreationDate": dateFormatter.string(from: accountCreationDate),
            "admin": isAdmin,
            "likedNewsIds": likedProjectNewsKeys,
            "likedOrganizationNewsIds": likedOrganizationNewsKeys,
            "subcribedProjectsIds": subcribedProjectsKeys
            ]
        return snapshot
    }
    
    
}
