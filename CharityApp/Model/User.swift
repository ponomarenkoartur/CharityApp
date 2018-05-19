//
//  User.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

class User {
    var email: String
    var password: String
    var firstName: String?
    var surname: String?
    var accountCreationDate: Date
    var isAdmin: Bool
    var likedNewsIds: [String]
    var likedOrganizationNewsIds: [String]
    
    init(email: String, password: String, firstName: String?, surname: String?, accountCreationDate: Date, isAdmin: Bool, likedNewsIds: [String], likedOrganizationNewsIds: [String]) {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.surname = surname
        self.accountCreationDate = accountCreationDate
        self.isAdmin = isAdmin
        self.likedNewsIds = likedNewsIds
        self.likedOrganizationNewsIds = likedOrganizationNewsIds
    }
    
    func getSnapshot() -> [String: Any] {
        var snapshot: [String: Any] = [
            "email": email,
            "password": password,
            "accountCreationDate": dateFormatter.string(from: accountCreationDate),
            "isAdmin": isAdmin,
            "likedNewsIds": likedNewsIds,
            "likedOrganizationNewsIds": likedOrganizationNewsIds
            ]
        
        if let firstName = firstName {
            snapshot["firstName"] = firstName
        }
        
        if let surname = surname {
            snapshot["surname"] = surname
        }
        
        return snapshot
    }
    
    
}
