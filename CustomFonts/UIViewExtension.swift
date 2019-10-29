//
//  UIViewExtension.swift
//  CustomFonts
//
//  Created by Abdulrahman Qasem on 10/29/19.

//

import Foundation
import UIKit
extension UIView {
    func shake()  {
           let animation = CABasicAnimation(keyPath: "position")
           animation.duration = 0.07
           animation.repeatCount = 4
           animation.autoreverses = true
           animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
           animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
           self.layer.add(animation, forKey: "position")
       }
}
