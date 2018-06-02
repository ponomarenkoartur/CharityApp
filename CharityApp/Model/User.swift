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
    var likedNewsKeys: [String: String]
    var likedOrganizationNewsKeys: [String]
    var subcribedProjectsKeys: [String]
    
    // MARK: - Initialization
    
    init(key: String?, email: String, accountCreationDate: Date = Date(), isAdmin: Bool = false, likedNewsKeys: [String: String] = [:], likedOrganizationNewsKeys: [String] = [], subcribedProjectsKeys: [String] = []) {
        self.key = key
        self.email = email
        self.accountCreationDate = accountCreationDate
        self.isAdmin = isAdmin
        self.likedNewsKeys = likedNewsKeys
        self.likedOrganizationNewsKeys = likedOrganizationNewsKeys
        self.subcribedProjectsKeys = subcribedProjectsKeys
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key as String
        email = snapshot.childSnapshot(forPath: "email").value as! String
        accountCreationDate = dateFormatter.date(from: snapshot.childSnapshot(forPath: "accountCreationDate").value as! String)!
        isAdmin = snapshot.childSnapshot(forPath: "isAdmin").value as! Bool
        // TODO: Replace with real data
        likedNewsKeys = [:]
        
        if let likedOrganizationNewsKeysString = snapshot.childSnapshot(forPath: "likedOrganizationNewsIds").value as? String {
                likedOrganizationNewsKeys = likedOrganizationNewsKeysString.split { $0 == "," }.map(String.init)
        } else {
            likedOrganizationNewsKeys = []
        }
        
        if let subcribedProjectsKeysString = snapshot.childSnapshot(forPath: "subcribedProjectsIds").value as? String {
            subcribedProjectsKeys = subcribedProjectsKeysString.split { $0 == "," }.map(String.init)
        } else {
            subcribedProjectsKeys = []
        }
    }
    
    // MARK: - Methods
    
    func isLikedOrganizationNews(_ news: OrganizationNews) -> Bool {
        if let key = news.key {
            return likedOrganizationNewsKeys.contains(key)
        } else {
            return false
        }
    }
    
    func isSubscribedProject(_ project: Project) -> Bool {
        if let key = project.key {
            return subcribedProjectsKeys.contains(key)
        } else {
            return false
        }
    }
    
    // MARK: - SnapshotConvertible
    
    func convertToSnapshot() -> [String: Any] {
        let snapshot: [String: Any] = [
            "email": email,
            "accountCreationDate": dateFormatter.string(from: accountCreationDate),
            "isAdmin": isAdmin,
            "likedNewsIds": likedNewsKeys,
            "likedOrganizationNewsIds": likedOrganizationNewsKeys,
            "subcribedProjectsIds": subcribedProjectsKeys
            ]
        return snapshot
    }
    
    
}
