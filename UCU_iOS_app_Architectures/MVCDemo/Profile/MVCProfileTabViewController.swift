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
class MVCProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var headerView: MVCProfileTabHeaderView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Properties
    let userAPIClient = UserAPIClient()
    let imageAPIClient = ImageAPIClient()
    
    var user: User?
    var myProfileScreen: Bool = true

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMVCEditProfileViewController", let editProfileVC = segue.destination as? MVCEditProfileViewController {
            
            editProfileVC.user = user
            editProfileVC.delegate = self
        }
    }
    
    // MARK: - Private
    private func setupUI() {
        descriptionLabel.textColor = .iris
        descriptionLabel.font = UIFont(name: "AvenirNext-Regular", size: 14.0)
        
        //headerView
        headerView.nameLabel.textColor = .iris
        headerView.nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 16.0)
        
        // User or Friend
        if myProfileScreen {
            userAPIClient.getMe { [weak self] (user) in
                self?.user = user
                self?.setUserData(user: user)
            }
        } else {
            setFriendProfile()
            guard let user = user else { return }
            setUserData(user: user)
        }
    }
    
    private func setFriendProfile() {
        editButton.isHidden = true
        cancelButton.isHidden = false
    }
    
    private func setUserData(user: User) {
        headerView.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        descriptionLabel.text = "\((user.firstName ?? "") + " " + (user.lastName ?? "")) was born in \(user.city ?? ""), \(user.country ?? "")"
        
        if let image = user.image {
            headerView.avatarImageView.image = image
        } else {
            imageAPIClient.loadImage(url: user.avatarURL) { [weak self] image in
                self?.user!.image = image
                self?.headerView.avatarImageView.image = image
            }
            
        }
    }
    
    // MARK: - IBActions
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
// MARK: - EditProfileVC Delegate
//
extension MVCProfileViewController: MVCEditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: MVCEditProfileViewController) {
        self.user = editProfileVC.user
        headerView.nameLabel.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
        descriptionLabel.text = "\((user?.firstName ?? "") + " " + (user?.lastName ?? "")) was born in \(user?.city ?? ""), \(user?.country ?? "")"
    }
}
