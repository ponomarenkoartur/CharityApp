//
//  ProjectNewsCell.swift
//  CharityApp
//
//  Created by Artur on 6/18/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ProjectNewsCell: NewsCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var projectNameButton: UIButton!
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Actions
    
    @IBAction func projectNameButtonWasTapped(_ sender: UIButton!) {
        if let news = news as? ProjNews {
            delegate?.newsCellDidTapProjectNameButton!(self, onNews: news)
        }
    }
    
    // MARK: - Methods
    
    override func configure(forNews news: News, ofProject project: Project? = nil) {
        super.configure(forNews: news, ofProject: project)
        
        // Set appearence of 'projectNameButton'
        if let news = news as? ProjNews,
            let projectTitle = news.parentProjectTitle {
            projectNameButton?.setTitle(projectTitle, for: .normal)
            projectNameButton?.sizeToFit()
        }
    }
}
