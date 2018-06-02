//
//  NewsVC.swift
//  CharityApp
//
//  Created by Artur on 6/1/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NewsVC: UITableViewController {

    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let news0 = OrganizationNews(key: nil, title: "Title0", text: "Text0Text0Text0Text0Text0Text0Text0Text0Text0Text0Text0Text0", date: Date())
        let news1 = ProjectNews(key: nil, title: "Title1", text: "Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1Text1", date: Date())
        
        news.append(news0)
        news.append(news1)
        // TODO: Load real news for the user from firebase
    }
}
