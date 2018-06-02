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
}

class ProjectCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var raiseMoneyStatusLabel: UILabel!
    @IBOutlet weak var raiseMoneyStatusProgressView: UIProgressView!
    
    // MARK: - Properties
    
    weak var delegate: ProjectCellDelegate?
    var project: Project?
    
    
    // MARK: - Actions
    
    @IBAction func moreButtonWasTapped(_ sender: UIButton) {
        delegate?.projectCellDidTapMoreButton(self, onProject: project!)
    }
    
}
