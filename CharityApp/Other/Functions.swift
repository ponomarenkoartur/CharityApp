//
//  Functions.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd HH:mm"
    return formatter
}()

func makeCell(for tableView: UITableView, withIdentifier identifier: String, style: UITableViewCellStyle = .default) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
                UITableViewCell(style: style, reuseIdentifier: identifier)
    return cell
}

extension UIView {
    func roundCorners(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 2, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 2, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: Double = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 256.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 256.0
        let blue = CGFloat(hex & 0xFF) / 256.0
        self.init(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

