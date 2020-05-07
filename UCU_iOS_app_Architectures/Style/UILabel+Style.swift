//
//  UILabel+Style.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/29/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

extension UILabel {
    func applyHeaderStyle() {
        self.textColor = .iris
        font = UIFont.getUCUFont(.bold, 16.0)
    }
    
    func applyHeaderStyle2() {
        self.textColor = .iris
        font = UIFont.getUCUFont(.medium, 16.0)
    }
 
    func applyBodyStyle() {
        self.textColor = .iris
        font = UIFont.getUCUFont(.regular, 12.0)
    }
}
