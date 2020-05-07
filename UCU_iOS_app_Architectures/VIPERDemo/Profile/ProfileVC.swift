//
//  ProfileVC.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - View Controller
//
class ProfileVC: UIViewController, VIPERProfileViewProtocol {

    // MARK: - IBOutlets
    @IBOutlet weak var headerView: VIPERProfileHeaderView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    // MARK: - Properties
    var presenter: VIPERProfilePresenterProtocol!
    let configurator: ProfileConfiguratorProtocol = ProfileConfigurator()
    
    var friend: User?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView(user: friend)
    }
    
    // MARK: - Protocol
    func setUserData(user: User) {
        headerView.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        descriptionLabel.text = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
        if let image = user.image {
            headerView.avatarImageView.image = image
        } else {
            presenter.loadImage(user: user)
        }
    }
    
    func setFriendView() {
        editButton.isHidden = true
        cancelButton.isHidden = false
    }

    // MARK: - IBActions
    @IBAction func editTapped(_ sender: Any) {
        presenter.editButtonTapped()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        presenter.cancelTapped()
    }
}

//
// MARK: - EditVC Delegate
//
extension ProfileVC: VIPEREditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: EditVC) {
        guard let user = editProfileVC.user else { return }
        presenter.showMyProfile(user: user)
    }
}
