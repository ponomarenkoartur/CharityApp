//
//  Functions.swift
//  CharityApp
//
//  Created by Artur on 3/10/18.
//  Copyright © 2018 Artur. All rights reserved.
//

import UIKit

func makeCell(for tableView: UITableView, withIdentifier identifier: String, style: UITableViewCellStyle = .default) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ??
                UITableViewCell(style: style, reuseIdentifier: identifier)
    return cell
}

func shakeView(_ viewToShake: UIView) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 3
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x - 2, y: viewToShake.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: viewToShake.center.x + 2, y: viewToShake.center.y))
    
    viewToShake.layer.add(animation, forKey: "position")
}

func roundCorners(of viewToRound: UIView, withCornerRadius cornerRadius: CGFloat) {
    viewToRound.layer.cornerRadius = cornerRadius
    viewToRound.clipsToBounds = true
}
