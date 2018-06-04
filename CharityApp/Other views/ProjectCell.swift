//
//  ProjectCell.swift
//  CharityApp
//
//  Created by Artur on 5/30/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

protocol ProjectCellDelegate: class {
    func projectCellDidTapMoreButton(_ cell: ProjectCell, onProject project: Project)
    func projectCellDidSubscribe(_ cell: UITableViewCell, toProject project: Project)
    func projectCellDidUnsubscribe(_ cell: UITableViewCell, fromProject project: Project)
}

class ProjectCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var raiseMoneyStatusLabel: UILabel!
    @IBOutlet weak var raiseMoneyStatusProgressView: UIProgressView!
    @IBOutlet weak var subscribeButton: UIButton!
    
    
    // MARK: - Properties
    
    weak var delegate: ProjectCellDelegate?
    var project: Project?
    var isSubscribed = false
    
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {        
        if isSubscribed {
            subscribeButton.setImage(#imageLiteral(resourceName: "bell-filled"), for: .normal)
            subscribeButton.setTitle("Unsubscribe", for: .normal)
        } else {
            subscribeButton.setImage(#imageLiteral(resourceName: "bell-outline"), for: .normal)
            subscribeButton.setTitle("Subscribe", for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func moreButtonWasTapped(_ sender: UIButton) {
        if let project = project {
            delegate?.projectCellDidTapMoreButton(self, onProject: project)
        }
    }
    
    @IBAction func subscribeButtonWasTapped(_ sender: UIButton) {
        if let project = project {
            // Remove space between button's image and text
            subscribeButton.titleLabel!.text!.removeFirst()
            if isSubscribed {
                delegate?.projectCellDidUnsubscribe(self, fromProject: project)
                subscribeButton.setImage(#imageLiteral(resourceName: "bell-outline"), for: .normal)
                subscribeButton.setTitle("Subscribe", for: .normal)
                
            } else {
                delegate?.projectCellDidSubscribe(self, toProject: project)
                subscribeButton.setImage(#imageLiteral(resourceName: "bell-filled"), for: .normal)
                subscribeButton.setTitle("Unsubscribe", for: .normal)
            }
            isSubscribed = !isSubscribed
        }
    }
    
    
}
