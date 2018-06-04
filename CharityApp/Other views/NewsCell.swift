//
//  NewsCell.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

protocol NewsCellDelegate: class {
    func newsCellDidTapMoreButton(_ cell: UITableViewCell, onNews news: News)
    func newsCellDidLike(_ cell: UITableViewCell, onNews news: News)
    func newsCellDidUnlike(_ cell: UITableViewCell, onNews news: News)
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
    var news: News?
    var isLiked = false
    
    // MARK: Cell Lifecycle
    
    override func awakeFromNib() {
       
       projectNameButton.imageView!.heightAnchor.constraint(equalToConstant: 5)
        projectNameButton.imageView!.widthAnchor.constraint(equalToConstant: 5)
        
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
            // Remove space between button's image and text
            likeButton.titleLabel!.text!.removeFirst()
            if isLiked {
                news.likesCount -= 1
                delegate?.newsCellDidUnlike(self, onNews: news)
                likeButton.setTitle(" \(news.likesCount)", for: .normal)
                likeButton.setImage(#imageLiteral(resourceName: "heart-outine"), for: .normal)
            } else {
                news.likesCount += 1
                delegate?.newsCellDidLike(self, onNews: news)
                likeButton.setTitle(" \(news.likesCount)", for: .normal)
                likeButton.setImage(#imageLiteral(resourceName: "heart-filled"), for: .normal)
            }
            isLiked = !isLiked
        }
    }
}
