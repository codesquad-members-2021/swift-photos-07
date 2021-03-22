//
//  UIColor+ext.swift
//  PhotosApp
//
//  Created by Lia on 2021/03/22.
//

import Foundation
import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        let redLevel = CGFloat.random(in: 0...1)
        let greenLevel = CGFloat.random(in: 0...1)
        let blueLevel = CGFloat.random(in: 0...1)

        let color = UIColor(red: redLevel, green: greenLevel, blue: blueLevel, alpha: 1)
        
        return color
    }
}
