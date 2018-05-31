//
//  ProjectNews.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

class ProjectNews: News {
    
    // MARK: SnapshotConvertible
    
    override func convertToSnapshot() -> [String: Any] {
        var snapshot = super.convertToSnapshot()
        snapshot["organizationNews"] = false
        return snapshot
    }
}
