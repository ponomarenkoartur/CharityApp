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
    var isAdmin: Bool
    var likedProjectNewsKeys: [String: [String]]
    var likedOrganizationNewsKeys: [String]
    var subcribedProjectsKeys: [String]
    
    // MARK: - Initialization
    
    init(key: String?, isAdmin: Bool = false, likedNewsKeys: [String: [String]] = [:], likedOrganizationNewsKeys: [String] = [], subcribedProjectsKeys: [String] = []) {
        self.key = key
        self.isAdmin = isAdmin
        self.likedProjectNewsKeys = likedNewsKeys
        self.likedOrganizationNewsKeys = likedOrganizationNewsKeys
        self.subcribedProjectsKeys = subcribedProjectsKeys
    }
    
    init(snapshot: DataSnapshot) {
        print(snapshot)
        key = snapshot.key as String
        isAdmin = snapshot.childSnapshot(forPath: "admin").value as! Bool
        
        likedProjectNewsKeys = [:]
        for likedProjectNews in snapshot.childSnapshot(forPath: "likedNewsPosts").children {
            if let likedProjectNews = likedProjectNews as? DataSnapshot {
                let projectName = likedProjectNews.key
                var likedProjectNewsString = likedProjectNews.value as! String
                
                likedProjectNewsKeys[projectName] = []
                if !likedProjectNewsString.isEmpty {
                    // Delete last comma
                    likedProjectNewsString.removeLast()
                    
                    likedProjectNewsKeys[likedProjectNews.key] = likedProjectNewsString.split { $0 == "," }.map(String.init)
                }
                
            }
        }
        
        likedOrganizationNewsKeys = []
        if let likedOrganizationNewsKeysString = snapshot.childSnapshot(forPath: "likedOrganizationNews").value as? String {
            if !likedOrganizationNewsKeysString.isEmpty {
                // Delete last comma
                var likedOrganizationNewsKeysCorrectString = likedOrganizationNewsKeysString
                likedOrganizationNewsKeysCorrectString.removeLast()
                
                likedOrganizationNewsKeys = likedOrganizationNewsKeysCorrectString.split { $0 == "," }.map(String.init)                
            }
        }
        
        if let subcribedProjectsKeysString = snapshot.childSnapshot(forPath: "subcribedNeeds").value as? String {
            // Delete last comma
            var correctedString = subcribedProjectsKeysString
            if !correctedString.isEmpty {
                correctedString.removeLast()
            }
            
            subcribedProjectsKeys = correctedString.split { $0 == "," }.map(String.init)
        } else {
            subcribedProjectsKeys = []
        }
    }
    
    // MARK: - Methods
    
    func isLikedNews(_ news: News, ofProjectWithKey projectKey: String?) -> Bool {
        guard let newsKey = news.key else {
            return false
        }
        if let _ = news as? OrgNews {
            return likedOrganizationNewsKeys.contains(newsKey)
        } else if let _ = news as? ProjNews,
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
            "admin": isAdmin,
            "likedNewsIds": likedProjectNewsKeys,
            "likedOrganizationNewsIds": likedOrganizationNewsKeys,
            "subcribedProjectsIds": subcribedProjectsKeys
            ]
        return snapshot
    }
    
    
}
