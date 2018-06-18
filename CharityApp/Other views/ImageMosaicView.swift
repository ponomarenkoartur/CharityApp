//
//  ImageMosaicView.swift
//  CharityApp
//
//  Created by Artur on 6/16/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class ImageMosaicView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet var imageViews: [UIImageView]!
    
    // MARK: - Constants
    
    private let maxImageViewCount = 4
    private let minImageViewCount = 0
    
    // MARK: - Properties
    
    var urlStrings: [String] = [] {
        didSet {
            imageViewCount = urlStrings.count
            let upperBound = maxImageViewCount > urlStrings.count ? urlStrings.count : maxImageViewCount
            for i in 0..<upperBound {
                if let url = URL(string: urlStrings[i]) {
                    let _ = imageViews[i].loadImage(url: url)
                }
            }
        }
    }
    
    private var imageViewCount = 4 {
        didSet {
            if imageViewCount < minImageViewCount {
                imageViewCount = minImageViewCount
            } else if imageViewCount > maxImageViewCount {
                imageViewCount = maxImageViewCount
            }
            
            if imageViewCount == minImageViewCount {
                frame = CGRect.zero
            }
            
            for i in 0..<(maxImageViewCount - imageViewCount) {
                let imageViewIndexToRemove = maxImageViewCount - 1 - i
                imageViews[imageViewIndexToRemove].removeFromSuperview()
            }
        }
    }
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromNib()
    }
    
    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "ImageMosaicView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
        return view
    }
}
