//
//  ProfileTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - Presenter Protocol
//
protocol ProfilePresenterProtocol {
    func viewDidLoad(isFriendScreen: Bool)
    func getUserForEditing() -> User?
    func setFriendUser(user: User)
}

//
// MVP: Controller
// -----------------
final class MVPProfileViewController: UIViewController, ProfileViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var headerView: MVPProfileTabHeaderView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.applyBodyStyle()
        }
    }
    
    // MARK: - Properties
    var isFriendScreen: Bool = true
    private var profilePresenter: ProfilePresenterProtocol!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMVPEditProfileViewController", let editProfileVC = segue.destination as? MVPEditProfileViewController {
            
            if let user = profilePresenter.getUserForEditing() {
                editProfileVC.user = user
            }
            editProfileVC.delegate = self
        }
    }
    
    // MARK: - Public
    func setUser(user: User) {
        profilePresenter.setFriendUser(user: user)
    }
    
    func createPresenter() {
        if profilePresenter == nil {
            profilePresenter = ProfilePresenter(view: self)
        }
    }
    
    // MARK: - Presenter Protocol
    func userLoaded(user: User) {
        headerView.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        headerView.avatarImageView.image = user.image
        descriptionLabel.text = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
    }
    
    func setFriendProfileScreen(isFriendProfile: Bool) {
        editButton.isHidden = isFriendProfile
        cancelButton.isHidden = !isFriendProfile
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // Presenter
        createPresenter()
        
        // Data
        profilePresenter.viewDidLoad(isFriendScreen: isFriendScreen)
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
// MARK: - EditVC Delegate
//
extension MVPProfileViewController: MVPEditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: MVPEditProfileViewController) {
    }
}
