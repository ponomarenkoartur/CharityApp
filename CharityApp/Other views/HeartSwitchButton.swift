//
//  HeartSwitchButton.swift
//  CharityApp
//
//  Created by Artur on 5/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class HeartSwitchButton: UIButton {
    var isOn: Bool {
        didSet {
            setImage()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        isOn = true
        super.init(coder: aDecoder)
        setImage()
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    private func setImage() {
        let stateImage = isOn ? #imageLiteral(resourceName: "heart-filled") : #imageLiteral(resourceName: "heart-outine")
        setImage(stateImage, for: .normal)
    }
    
    @objc private func toggle() {
        isOn = !isOn
    }
}
