//
//  UIFontExtension.swift
//  Guava
//
//  Created by Marko Budal on 08/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

enum FontWeight: String {
    case ABlack = "Avenir-Black"
    case AHeavy = "Avenir-Heavy"
    
}

extension UIFont {
    class func avenir(weight: FontWeight, size: CGFloat) -> UIFont? {
        return UIFont(name: weight.rawValue, size: size)
    }
}
