//
//  ProfileTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MVC: Controller
// -----------------
final class MVCProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var headerView: MVCProfileTabHeaderView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    // MARK: - Properties
    private let userAPIClient = UserAPIClient()
    private let imageAPIClient = ImageAPIClient()
    
    private var user: User?
    var isFriendProfile: Bool = true

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMVCEditProfileViewController", let editProfileVC = segue.destination as? MVCEditProfileViewController {
            
            editProfileVC.setUser(user: user)
            editProfileVC.delegate = self
        }
    }
    
    // MARK: - Public
    func setFriend(user: User) {
        self.user = user
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // User or Friend
        if isFriendProfile {
            userAPIClient.getMe { [weak self] (user) in
                self?.user = user
                self?.setUserData(user: user, isFriendProfile: false)
            }
        } else {
            guard let user = user else { return }
            setUserData(user: user, isFriendProfile: true)
        }
    }
    
    private func setFriendProfile(isFriendProfile: Bool) {
        editButton.isHidden = isFriendProfile
        cancelButton.isHidden = !isFriendProfile
    }
    
    private func setUserData(user: User, isFriendProfile: Bool) {
        headerView.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        let joinedString = JoinedString()
        let locationText = joinedString.append(user.city).append(user.country).result
        descriptionLabel.text = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(locationText == "" ? "nowhere" : locationText)"
        
        if let image = user.image {
            headerView.avatarImageView.image = image
        } else {
            loadImage(user: user)
        }
        
        if isFriendProfile { setFriendProfile(isFriendProfile: isFriendProfile) }
    }
    
    private func loadImage(user: User) {
        imageAPIClient.loadImage(url: user.avatarURL) { [weak self] image in
            user.image = image
            self?.headerView.avatarImageView.image = image
        }
    }
    
    // MARK: - IBActions
    @IBAction private func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
// MARK: - EditProfileVC Delegate
//
extension MVCProfileViewController: MVCEditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: MVCEditProfileViewController) {
        if let user = user {
            setUserData(user: user, isFriendProfile: false)
        } else { setupUI() }
    }
}
