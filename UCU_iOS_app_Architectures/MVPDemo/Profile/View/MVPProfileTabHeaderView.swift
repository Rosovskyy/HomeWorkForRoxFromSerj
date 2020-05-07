//
//  ProfileTabHeaderView.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

// MVP: View
// -----------------
final class MVPProfileTabHeaderView: UIView {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.applyHeaderStyle()
        }
    }
    @IBOutlet weak var avatarImageView: UIImageView!
    
}
