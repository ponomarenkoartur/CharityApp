//
//  NewsCell.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    // MARK: - Methods
    
    func setLikeCounterLabelText(to text: String) {
        likeCountLabel.text = "\(text) likes"
        likeCountLabel.sizeToFit()
    }
}


