//
//  User.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

class User {
    var firstName: String?
    var surname: String?
    var email: String
    var accountCreationDate: Date
    var isAdmin: Bool
    var likedNewsIds: [String]
    var likedOrganizationNewsIds: [String]
    
    init(email: String, firstName: String, surname: String, accountCreationDate: Date, isAdmin: Bool, likedNewsIds: [String], likedOrganizationNewsIds: [String]) {
        self.email = email
        self.firstName = firstName
        self.surname = surname
        self.accountCreationDate = accountCreationDate
        self.isAdmin = isAdmin
        self.likedNewsIds = likedNewsIds
        self.likedOrganizationNewsIds = likedOrganizationNewsIds
    }
    
    func getSnapshot() -> [String: Any] {
        return ["email": self.email]
    }
    
    
}
