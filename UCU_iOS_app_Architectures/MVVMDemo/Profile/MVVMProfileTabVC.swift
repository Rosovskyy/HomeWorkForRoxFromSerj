//
//  ProfileTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit
import NSObject_Rx

// MVVM: Controller
// -----------------
final class MVVMProfileViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet private weak var headerView: MVVMProfileTabHeaderView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    // MARK: - Properties
    private lazy var viewModel: ProfileVM = {
        return ProfileVM()
    }()
    
    var myProfileScreen: Bool = true
    var friend: User?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        prepareBind()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMVVMEditProfileViewController", let editProfileVC = segue.destination as? MVVMEditProfileViewController {
            
            editProfileVC.user = viewModel.user.value
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
        
        // Data
        if myProfileScreen {
            viewModel.initFetch()
        } else {
            setFriendProfile()
        }
    }
    
    private func prepareBind() {
        viewModel.user.bind { [weak self] user in
            self?.headerView.nameLabel.text = self?.viewModel.getUserFullName()
            self?.descriptionLabel.text = self?.viewModel.getUserLocation()
            self?.headerView.avatarImageView.image = self?.viewModel.getUserImage()
        }.disposed(by: rx.disposeBag)
        
        viewModel.profileImage.bind { [weak self] image in
            self?.headerView.avatarImageView.image = image
        }.disposed(by: rx.disposeBag)
    }
    
    private func setFriendProfile() {
        editButton.isHidden = true
        cancelButton.isHidden = false
        
        viewModel.user.accept(friend ?? User())
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//
// MARK: - EditVC Delegate
//
extension MVVMProfileViewController: MVVMEditProfileViewControllerDelegate {
    func editProfileViewControllerDidSave(_ editProfileVC: MVVMEditProfileViewController) {
        guard let user = editProfileVC.user else { return }
        viewModel.user.accept(user)
    }
}
