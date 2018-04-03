//
//  Functions.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

func makeCell(for tableView: UITableView, withIdentifier identifier: String, style: UITableViewCellStyle = .default) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
                UITableViewCell(style: style, reuseIdentifier: identifier)
    return cell
}
