//
//  OrganizationInfoCell.swift
//  CharityApp
//
//  Created by Artur on 6/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class OrganizationInfoCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var linkButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(forOrganization organization: Organization) {
        titleLabel.text = organization.name
        descriptionTextView.text = organization.description
        linkButton.setTitle(organization.contactInformation, for: .normal)
    }
}
