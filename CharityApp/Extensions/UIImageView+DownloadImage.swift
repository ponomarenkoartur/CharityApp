//
//  UIImageView+DownloadImage.swift
//  CharityApp
//
//  Created by Artur on 6/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url) { [weak self] url, response, error in
            if error == nil,
                let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        strongSelf.image = image
                    }
                }
            } else {
                print("Image could not be loaded. Error: \(error!)")
            }
        }
        downloadTask.resume()
        return downloadTask
    }
    
    func loadImageUsingCache(withUrlString urlString: String) {
        
        // Check if cache contains image
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // Otherwise load image
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url) { [weak self] url, response, error in
            if error == nil,
                let url = url,
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        imageCache.setObject(image, forKey: urlString as AnyObject)
                        strongSelf.image = image
                    }
                }
            } else {
                print("Image could not be loaded. Error: \(error!)")
            }
        }
        downloadTask.resume()
    }
}

