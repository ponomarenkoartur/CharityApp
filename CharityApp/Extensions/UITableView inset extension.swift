//
//  UITableView inset extension.swift
//  CharityApp
//
//  Created by Artur on 6/4/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

extension UITableViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsets.zero
    } 
}
