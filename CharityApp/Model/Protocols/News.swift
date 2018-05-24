//
//  InfoItem.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//
import Foundation

protocol News: InfoItem {
    
    // MARK: - Properties
    
    var likesCount: Int { get set }
}
