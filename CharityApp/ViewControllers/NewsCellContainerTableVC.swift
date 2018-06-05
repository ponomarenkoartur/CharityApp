//
//  NewsCellContainerTableVC.swift
//  CharityApp
//
//  Created by Artur on 6/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NewsCellContainerTableVC: UITableViewController, NewsCellDelegate {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News) {
        
    }
    
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News) {
        if news is OrganizationNews,
            let currentUser = AuthService.instance.currentUser {
            DataService.instance.likeNews(news, ofProject: nil, byUser: currentUser) { status in
                if status, let key = news.key {
                    currentUser.likedOrganizationNewsKeys.append(key)
                }
            }
        } else if let news = news as? ProjectNews,
            let projectKey = news.parentProjectKey,
            let currentUser = AuthService.instance.currentUser {
            DataService.instance.likeNews(news, ofProjectWithKey: projectKey, byUser: currentUser) { status in
                if status,
                    let newsKey = news.key {
                    if currentUser.likedProjectNewsKeys.keys.contains(projectKey) {
                        currentUser.likedProjectNewsKeys[projectKey]!.append(newsKey)
                    } else {
                        currentUser.likedProjectNewsKeys[projectKey] = []
                        currentUser.likedProjectNewsKeys[projectKey]!.append(newsKey)
                    }
                }
            }
        }
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        
    }
}

