//
//  ProjectCell.swift
//  CharityApp
//
//  Created by Artur on 5/30/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var raiseMoneyStatusLabel: UILabel!
    @IBOutlet weak var raiseMoneyStatusProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
