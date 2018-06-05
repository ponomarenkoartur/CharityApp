//
//  NotificationSenderService.swift
//  CharityApp
//
//  Created by Artur on 6/5/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class NotificationSenderService {
    
    // MARK: - Properties
    
    static let instance = NotificationSenderService()
    
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Methods
    
    func sendNotification(withTopic topic: String, newsId: String, newsTitle: String, newsText: String) {
        dataTask?.cancel()
        
        let headers = [
            "topic": topic,
            "newsId": newsId,
            "messageTitle": newsTitle,
            "messageText": newsText
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://charityappserver.herokuapp.com/sendmessage")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error as? NSError {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })
    }
}
