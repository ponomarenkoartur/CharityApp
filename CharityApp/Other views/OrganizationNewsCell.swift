//
//  NewsCell.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

protocol OrganizationNewsCellDelegate: class {
    func organizationNewsCellDelegateDidTapMoreButton(_ cell: UITableViewCell)
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
    
    // MARK: - Actions
    
    @IBAction func moreButtonWasTapped(_ sender: UIButton) {
        delegate?.organizationNewsCellDelegateDidTapMoreButton(self)
    }
    
}


