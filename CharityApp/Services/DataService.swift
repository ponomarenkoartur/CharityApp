//
//  DataService.swift
//  CharityApp
//
//  Created by Artur on 5/19/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference().child("Example22")

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_ORGANIZATION_NEWS = DB_BASE.child("organizationNews")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_ORGANIZATION_NEWS: DatabaseReference {
        return _REF_ORGANIZATION_NEWS
    }
    
    func createDBUser(uid: String, userData: [String: Any]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadOrganizationNews(_ news: OrganizationNews, sendComplete: @escaping (_ status: Bool) -> ()) {
        REF_ORGANIZATION_NEWS.childByAutoId().updateChildValues(news.convertToSnapshot())
        sendComplete(true)
    }
}
