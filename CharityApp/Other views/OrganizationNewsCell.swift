//
//  NewsCell.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

protocol OrganizationNewsCellDelegate: class {
    func organizationNewsCellDelegateDidTapMoreButton(_ cell: UITableViewCell, onNews news: News)
}

class OrganizationNewsCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Properties
    
    weak var delegate: OrganizationNewsCellDelegate?
    var news: News?
    
    // MARK: - Actions
    
    @IBAction func moreButtonWasTapped(_ sender: UIButton) {
        if let news = news {
            delegate?.organizationNewsCellDelegateDidTapMoreButton(self, onNews: news)            
        }
    }
    
}


