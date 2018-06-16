//
//  ImagesSet.swift
//  CharityApp
//
//  Created by Artur on 6/15/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ImagesSet: UIView {

    var imageViews: [UIImageView]!
    var urlStrings: [String] = [] {
        didSet {
            imageViewCount = urlStrings.count
            let upperBound = maxImageViewCount > urlStrings.count ? urlStrings.count : maxImageViewCount
            for i in 0..<upperBound {
                if let url = URL(string: urlStrings[i]) {
                    imageViews[i].loadImage(url: url)
                }
            }
        }
    }
    
    private let maxImageViewCount = 4
    private let minImageViewCount = 0
    
    private var imageViewCount = 4 {
        didSet {
            if imageViewCount < minImageViewCount {
                imageViewCount = minImageViewCount
            } else if imageViewCount > maxImageViewCount {
                imageViewCount = maxImageViewCount
            }
            
            for i in 0..<(maxImageViewCount - imageViewCount) {
                let imageViewIndexToRemove = maxImageViewCount - 1 - i
                imageViews[imageViewIndexToRemove].removeFromSuperview()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
