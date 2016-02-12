//
//  UIColorExtension.swift
//  Guava
//
//  Created by Marko Budal on 04/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(hex: Int) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    class func facebookColor() -> UIColor{
        return UIColor(hex: 0x3E549C)
    }
    
    class func twitterColor() -> UIColor{
        return UIColor(hex: 0x27B4DA)
    }
}
