//
//  NewsCell.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

@objc protocol NewsCellDelegate: class {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News)
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News)
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News)
    @objc optional func newsCellDidTapProjectNameButton(_ cell: UITableViewCell, onNews news: News)
}

class NewsCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var projectNameButton: UIButton!
    
    
    // MARK: - Properties
    
    weak var delegate: NewsCellDelegate?
    var news: News? {
        didSet {
            // Hide view accoriding to cell appointment
            if news is OrganizationNews {
                if let superview = superview, superview.subviews.contains(projectNameButton) {
                    projectNameButton.removeFromSuperview()
                }
            } else if news is ProjectNews {
                if let superview = superview, superview.subviews.contains(logoImageView) {
                    logoImageView.removeFromSuperview()
                }
            }
        }
    }
    var isLiked = false
    
    // MARK: Cell Lifecycle
    
    override func awakeFromNib() {
        // Set appearence of 'likeButton'
        if isLiked {
            likeButton.setImage(#imageLiteral(resourceName: "heart-filled"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "heart-outine"), for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func moreButtonWasTapped(_ sender: UIButton) {
        if let news = news {
            delegate?.newsCellDidTapMoreButton(self, onNews: news)            
        }
    }
    
    @IBAction func likeButtonWasTapped(_ sender: UIButton) {
        if let news = news {
            isLiked = !isLiked
            if isLiked {
                news.likesCount += 1
                delegate?.newsCellDidLike(self, onNews: news)
                likeButton.setTitle("\(news.likesCount)", for: .normal)
                likeButton.setImage(#imageLiteral(resourceName: "heart-filled"), for: .normal)
            } else {
                news.likesCount -= 1
                delegate?.newsCellDidUnlike(self, onNews: news)
                likeButton.setTitle("\(news.likesCount)", for: .normal)
                likeButton.setImage(#imageLiteral(resourceName: "heart-outine"), for: .normal)
            }
        }
    }
    
    @IBAction func projectNameButtonWasTapped(_ sender: UIButton!) {
        if let news = news {
            delegate?.newsCellDidTapProjectNameButton!(self, onNews: news)
        }
    }
    
}