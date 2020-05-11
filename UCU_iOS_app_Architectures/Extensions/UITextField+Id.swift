//
//  UITextField+Id.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 09.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

extension UITextField {
    
    var id: String { get { return self.placeholder ?? "" } }
}
