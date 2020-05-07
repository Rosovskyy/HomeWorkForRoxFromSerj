//
//  FriendTableViewCell.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - TableViewCell
//
class MVCFriendTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel! {
           didSet {
               nameLabel.applyHeaderStyle2()
           }
       }
    @IBOutlet weak var avatarImageView: UIImageView!

    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        // Configure the view for the selected state
    }
}
