//
//  LikeControl.swift
//  CharityApp
//
//  Created by Artur on 5/4/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit
class LikeControl: UIStackView {
    
    // MARK: - Outlets
    
    var likes = 0
    
    @IBOutlet weak var heart: UISwitch!
    
    // MARK: - Initialization
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        if let _ = heart {
            heart.onImage = #imageLiteral(resourceName: "heart-filled")
            heart.offImage = #imageLiteral(resourceName: "heart-outine")
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
