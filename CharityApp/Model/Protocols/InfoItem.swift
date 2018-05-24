//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import Foundation

protocol InfoItem: ImageContentCollectionContainer, SnapshotConvertible {
    
    // MARK: - Properties
    
    var key: String? { get set }
    var title: String { get set }
    var text: String { get set }
    var date: Date { get set }
    var imageUrlsCollection: [String : String] { get set }
    var tagsCollection: [String] { get set }
}
