//
//  LoginScreenButton.swift
//  CharityApp
//
//  Created by Artur on 8/29/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

@IBDesignable
class LoginScreenButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        customizeView()
    }

    func customizeView() {
        backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.1254901961, blue: 0.1647058824, alpha: 1)
        roundCorners(withRadius: 5)
        setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    }
}
