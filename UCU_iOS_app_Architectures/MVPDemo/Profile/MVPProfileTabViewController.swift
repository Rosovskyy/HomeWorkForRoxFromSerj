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
    func viewDidLoad()
    func getUserForEditing() -> User?
}

//
// MVP: Controller
// -----------------
class MVPProfileViewController: UIViewController, ProfileViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var headerView: MVPProfileTabHeaderView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.applyBodyStyle()
        }
    }
    
    // MARK: - Properties
    var user: User?
    var myProfileScreen: Bool = true
    private let profilePresenter = ProfilePresenter()

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
    
    // MARK: - Presenter Protocol
    func userLoaded(user: User) {
        headerView.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        headerView.avatarImageView.image = user.image
        descriptionLabel.text = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // Presenter
        profilePresenter.setViewDelegate(profileViewProtocol: self)
        
        // Data
        if myProfileScreen {
            profilePresenter.viewDidLoad()
        } else {
            setFriendProfile()
        }
    }
    
    private func setFriendProfile() {
        editButton.isHidden = true
        cancelButton.isHidden = false
        
        guard let user = user else { return }
        userLoaded(user: user)
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
        self.user = editProfileVC.user
        
        headerView.nameLabel.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")

        descriptionLabel.text = "\((user?.firstName ?? "") + " " + (user?.lastName ?? "")) was born in \(user?.city ?? ""), \(user?.country ?? "")"
    }
}
