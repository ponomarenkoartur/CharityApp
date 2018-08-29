//
//  MainTabBar.swift
//  CharityApp
//
//  Created by Artur on 5/23/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verticalCenterIcons()
    }
}

extension UITabBarController {
    func verticalCenterIcons() {
        for tabBarItem in self.tabBar.items! {
            tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
            tabBarItem.title = ""
        }
    }
}
