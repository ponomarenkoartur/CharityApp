//
//  ProjectNewsLabelCell.swift
//  CharityApp
//
//  Created by Artur on 6/4/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

protocol ProjectNewsHeaderCellDelegate: class {
    func projectNewsHeaderCellDidTapPlusButton(_ cell: ProjectNewsHeaderCell)
}

class ProjectNewsHeaderCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: ProjectNewsHeaderCellDelegate?
    
    // MARK: - Actions

    @IBAction func plusButtonWasTapped(_ sender: UIButton) {
        
    }
}
