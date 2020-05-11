//
//  AddFriendSecondScreenCell.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - CollectionViewCell
//
final class AddFriendLocationScreen: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var countryNameTextField: UITextField!
    
    // MARK: - Properties
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
