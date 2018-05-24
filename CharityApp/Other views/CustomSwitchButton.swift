//
//  CustomSwitchButton.swift
//  CharityApp
//
//  Created by Artur on 5/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSwitchButton: UIButton {
    
    @IBInspectable
    var isOn: Bool {
        didSet {
            let stateImage = isOn ? onImage : offImage
            setImage(stateImage, for: .normal)
        }
    }
    
    @IBInspectable
    var onImage: UIImage
    
    @IBInspectable
    var offImage: UIImage
    
    required init?(coder aDecoder: NSCoder) {
        onImage = #imageLiteral(resourceName: "heart-filled")
        offImage = #imageLiteral(resourceName: "heart-outine")
        isOn = true
        super.init(coder: aDecoder)
        setImage()
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    @objc private func toggle() {
        isOn = !isOn
    }
}
