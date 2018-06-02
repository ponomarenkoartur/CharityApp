//
//  NewsCell.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

protocol OrganizationNewsCellDelegate: class {
    func organizationNewsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: OrganizationNews)
    func organizationNewsCellDidLike(_ cell: UITableViewCell, onNews news: OrganizationNews)
    func organizationNewsCellDidUnlike(_ cell: UITableViewCell, onNews news: OrganizationNews)
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
    var news: OrganizationNews?
    var isLiked = false
    
    // MARK: Cell LifeCycle
    
    override func awakeFromNib() {
        if isLiked {
            likeButton.setImage(#imageLiteral(resourceName: "heart-filled"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "heart-outine"), for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func moreButtonWasTapped(_ sender: UIButton) {
        if let news = news {
            delegate?.organizationNewsCellDidTapMoreButton(self, onNews: news)            
        }
    }
    
    @IBAction func likeButtonWasTapped(_ sender: UIButton) {
        if let news = news {
            // Remove space between button's image and text
            likeButton.titleLabel!.text!.removeFirst()
            if isLiked {
                news.likesCount -= 1
                delegate?.organizationNewsCellDidUnlike(self, onNews: news)
                likeButton.setTitle(" \(news.likesCount)", for: .normal)
                likeButton.setImage(#imageLiteral(resourceName: "heart-outine"), for: .normal)
            } else {
                news.likesCount += 1
                delegate?.organizationNewsCellDidLike(self, onNews: news)
                likeButton.setTitle(" \(news.likesCount)", for: .normal)
                likeButton.setImage(#imageLiteral(resourceName: "heart-filled"), for: .normal)
            }
            self.isLiked = !isLiked
        }
    }
}
