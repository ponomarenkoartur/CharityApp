//
//  DonationsVC.swift
//  CharityApp
//
//  Created by Artur on 6/1/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

class DonationsVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Properties
    
    var dataTask: URLSessionDataTask?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = URL(string: "https://ib.fio.cz/ib/transparent?a=2300849910&l=ENGLISH") {
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest)
            
        }
        
//        let myURLString = "https://ib.fio.cz/ib/transparent?a=2300849910&l=ENGLISH"
//        guard let myURL = URL(string: myURLString) else {
//            print("Error: \(myURLString) doesn't seem to be a valid URL")
//            return
//        }
//
//        do {
//            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
//            print("HTML : \(myHTMLString)")
//        } catch let error {
//            print("Error: \(error)")
//        }
    }
}
