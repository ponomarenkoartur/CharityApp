//
//  UIImageView+DownloadImage.swift
//  CharityApp
//
//  Created by Artur on 6/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

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
}

