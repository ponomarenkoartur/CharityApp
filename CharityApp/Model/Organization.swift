//
//  Organization.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Firebase

class Organization: NewsContainer {
    
    // MARK: - Properties
    
    var info: OrganizationInfo
    var news: [String: News]?
    var needs: [String: Need]?
    
    // MARK: - Initialization
    
    init(info: OrganizationInfo) {
        self.info = info
    }
}
