//
//  Cell+Id.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static var id: String { get { return String(describing: self) } }
}

extension UICollectionViewCell {

    static var id: String { get { return String(describing: self) } }
}
