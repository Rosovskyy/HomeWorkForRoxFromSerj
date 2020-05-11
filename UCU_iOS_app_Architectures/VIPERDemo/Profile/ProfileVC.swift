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
final class ProfileVC: UIViewController, VIPERProfileViewProtocol {

    // MARK: - IBOutlets
    @IBOutlet private weak var headerView: VIPERProfileHeaderView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    
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
    func setUserData(fullName: String, location: String, image: UIImage) {
        headerView.nameLabel.text = fullName
        descriptionLabel.text = location
        headerView.avatarImageView.image = image
    }
    
    func setFriendView() {
        editButton.isHidden = true
        cancelButton.isHidden = false
    }

    // MARK: - IBActions
    @IBAction private func editTapped(_ sender: Any) {
        presenter.editButtonTapped()
    }
    
    @IBAction private func cancelTapped(_ sender: Any) {
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
