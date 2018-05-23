//
//  ConvertibleToDictionary.swift
//  CharityApp
//
//  Created by Artur on 3/7/18.
//  Copyright © 2018 Artur. All rights reserved.
//

protocol SnapshotConvertible {
    
    /**
     Returns `Dictionary`, where key is a name of propertie and value is its value
     Dictionary contains only primitive value, i.e. properties that conform to `NSArray`, `NSDictionary`, `NSString`, `NSNumber` protocols.
    */
    func convertToSnapshot() -> [String: Any]
}
