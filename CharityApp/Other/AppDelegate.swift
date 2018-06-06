//
//  AppDelegate.swift
//  CharityApp
//
//  Created by Artur on 3/6/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        // TODO: Show initialy main tab bar controller
        // and if user is not signed in then present 'loginVC'
        
        // Perform segue from 'Login' if user is signed in.
        if let _ = Auth.auth().currentUser {
            DataService.instance.getCurrentUser { (user) in
                AuthService.instance.currentUser = user
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let mainTabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarVC")
                self.window?.makeKeyAndVisible()
                self.window?.rootViewController?.present(mainTabBarVC, animated: true)
            }
        }
        
        // Set appearence
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.barTintColor = UIColor(hex: 0x2A66AE)
        navigationBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationBarAppearance.isTranslucent = false
        
        let tabBarAppearence = UITabBar.appearance()
        tabBarAppearence.tintColor = UIColor(hex: 0x2A66AE)
        tabBarAppearence.isTranslucent = false
        return true
    }
}

