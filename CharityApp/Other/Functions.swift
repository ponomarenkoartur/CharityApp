//
//  Functions.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
    return formatter
}()

func makeCell(for tableView: UITableView, withIdentifier identifier: String = "Cell", style: UITableViewCellStyle = .default) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
                UITableViewCell(style: style, reuseIdentifier: identifier)
    return cell
}
