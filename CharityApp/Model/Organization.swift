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

    var name: String
    var description: String
    var contactInformation: String
    var defaultAccountNumber: String
    var newsCollection: [News]
    var projectsCollection: [String: Project]
    
    // MARK: - Initialization
    
    init(name: String, description: String, contactInformation: String, defaultAccountNumber: String, newsCollection: [News] = [], projectsCollection: [String: Project] = [:]) {
        self.name = name
        self.description = description
        self.contactInformation = contactInformation
        self.defaultAccountNumber = defaultAccountNumber
        self.newsCollection = newsCollection
        self.projectsCollection = projectsCollection
    }
    
    init(snaphot: DataSnapshot) {
        self.name = snaphot.childSnapshot(forPath: "name").value as! String
        self.description = snaphot.childSnapshot(forPath: "description").value as! String
        self.contactInformation = snaphot.childSnapshot(forPath: "contactInformation").value as! String
        self.defaultAccountNumber = snaphot.childSnapshot(forPath: "defaultAccountNumber").value as! String
        newsCollection = []
        projectsCollection = [:]
    }
}
