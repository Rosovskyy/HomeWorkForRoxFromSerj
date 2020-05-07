//
//  UIColor+App.swift
//  StylesAndUI
//
//  Created by Roxane Gud on 2/7/16.
//  Copyright © 2016 Roxane Markhyvka. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: UInt8, green: UInt8, blue: UInt8, a: UInt8 = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
}

extension UIColor {
    
    class var iris: UIColor {
        return UIColor(red: 83.0 / 255.0, green: 70.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
    }
}
