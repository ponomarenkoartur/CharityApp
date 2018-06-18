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
        guard let user = AuthService.instance.currentUser else {
            return
        }
        if let news = news as? ProjectNews,
            let projectKey = news.parentProjectKey {
            DataService.instance.likeNews(news, ofProjectWithKey: projectKey, byUser: user) { status in
                if status,
                    let newsKey = news.key,
                    let projectKey = news.parentProjectKey {
                    if user.likedProjectNewsKeys.keys.contains(projectKey) {
                        user.likedProjectNewsKeys[projectKey]!.append(newsKey)
                    } else {
                        user.likedProjectNewsKeys[projectKey] = []
                        user.likedProjectNewsKeys[projectKey]!.append(newsKey)
                    }
                }
            }
        } else if let news = news as? OrganizationNews {
            DataService.instance.likeNews(news, ofProject: nil, byUser: user) { status in
                if status, let key = news.key {
                    user.likedOrganizationNewsKeys.append(key)
                }
            }
        }
    }
    
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News) {
        guard let currentUser = AuthService.instance.currentUser else {
            return
        }
        
        if let news = news as? ProjectNews,
            let projectKey = news.parentProjectKey {
            
            DataService.instance.unlikeNews(news, ofProjectWithKey: projectKey, byUser: currentUser) { (status) in
                print(status)
            }
        } else if let news = news as? OrganizationNews {
            DataService.instance.unlikeNews(news, ofProject: nil, byUser: currentUser) { (status) in
                if status {
                    for i in 0..<currentUser.likedOrganizationNewsKeys.count {
                        if currentUser.likedOrganizationNewsKeys[i] == news.key {
                            currentUser.likedOrganizationNewsKeys.remove(at: i)
                        }
                    }
                }
            }
        }
    }
}

