//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//
import Foundation

protocol News: ImageContentCollectionContainer, SnapshotConvertible {
    
    // MARK: - Properties
    
    var key: String? { get set }
    var title: String { get set }
    var text: String { get set }
    var likesCount: Int { get set }
    var date: Date { get set }
    var imageUrlsCollection: [String : String] { get set }
    var tagsCollection: [String: String] { get set }
}
