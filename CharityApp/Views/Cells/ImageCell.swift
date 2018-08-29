//
//  ImageCell.swift
//  CharityApp
//
//  Created by Artur on 6/15/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(forUrlString urlString: String) {
        if let url = URL(string: urlString) {
            let _ = myImageView.loadImage(url: url)
        }
    }
}
