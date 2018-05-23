//
//  MainTabBar.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class MainTabBar: UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        for tabBarItem in self.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
    }
}
