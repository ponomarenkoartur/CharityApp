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
    var images: [UIImage] = [] {
        didSet {
            let upperBound = maxImageViewCount > images.count ? images.count : maxImageViewCount
            for i in 0..<upperBound {
                imageViews[i].image = images[i]
            }
        }
    }
    
    let maxImageViewCount = 4
    let minImageViewCount = 0
    
    var imageViewCount = 4 {
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
