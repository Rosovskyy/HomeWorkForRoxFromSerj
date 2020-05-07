//
//  UIFont+App.swift
//  StylesAndUI
//
//  Created by Roxane Gud on 2/4/16.
//  Copyright © 2016 Roxane Markhyvka. All rights reserved.
//

import UIKit

enum FontType: Int {
    case regular = 0
    case medium
    case bold
}

extension UIFont {
    class func getUCUFont(_ fontType: FontType, _ size: CGFloat) -> UIFont {
        
        switch fontType {
        case .regular:
            return UIFont(name: "AvenirNext-Regular", size: size)!
        case .medium:
            return UIFont(name: "AvenirNext-Medium", size: size)!
        case .bold:
            return UIFont(name: "AvenirNext-Bold", size: size)!
        }
    }
}
