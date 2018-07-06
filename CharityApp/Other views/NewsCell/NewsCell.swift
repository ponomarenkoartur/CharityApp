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
    @objc optional func newsCellDidTapProjectNameButton(_ cell: UITableViewCell, onNews news: ProjectNews)
}

class NewsCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageMosaicView: ImageMosaicView!
    
    // MARK: - Properties
    
    weak var delegate: NewsCellDelegate?
    var news: News?
    
    var isLiked = false {
        didSet {
            // Set appearence of 'likeButton'
            if isLiked {
                likeButton.setImage(#imageLiteral(resourceName: "heart-filled"), for: .normal)
            } else {
                likeButton.setImage(#imageLiteral(resourceName: "heart-outine"), for: .normal)
            }
        }
    }
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for view in imageMosaicView.imageViews {
            view.image = #imageLiteral(resourceName: "image-stub")
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
                likeButton.setTitle("\(news.likesCount)", for: .normal)
                delegate?.newsCellDidLike(self, onNews: news)
            } else {
                news.likesCount -= 1
                likeButton.setTitle("\(news.likesCount)", for: .normal)
                delegate?.newsCellDidUnlike(self, onNews: news)
            }
        }
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMosaicView.appearDefaultImages()
    }
    
    func configure(forNews news: News, ofProject project: Project? = nil) {
        self.news = news
        titleLabel.text = news.title
        dateLabel.text = dateFormatter.string(from: news.date)
        textView.text = news.text
        likeButton.setTitle("\(news.likesCount)", for: .normal)
        imageMosaicView.urlStrings = news.imageUrlsCollection
        
        if let user = AuthService.instance.currentUser {
            isLiked = user.isLikedNews(news, ofProject: project)
        }
    }
}
