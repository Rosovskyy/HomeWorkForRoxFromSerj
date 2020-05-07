//
//  ProfilePresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 05.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Presenter Protocol
//
protocol ProfileViewProtocol: class {
    func userLoaded(user: User)
}

//
// MARK: - Presenter
//
final class ProfilePresenter: ProfilePresenterProtocol {
    
    // MARK: - Properties
    private let userAPIClient: UserAPIClient
    private let imageAPIClient: ImageAPIClient
    private weak var view: ProfileViewProtocol?
    
    private var user: User?
    
    // MARK: - Initialization
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()){
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    func setViewDelegate(profileViewProtocol: ProfileViewProtocol?){
        self.view = profileViewProtocol
    }
    
    // MARK: - Protocol
    func viewDidLoad() {
        getUser()
    }
    
    func getUserForEditing() -> User? {
        guard let user = user else { return nil }
        return user
    }
    
    // MARK: - Private
    private func getUser() {
        userAPIClient.getMe { [weak self] user in
            self?.user = user
            self?.view?.userLoaded(user: user)
            self?.loadImage()
        }
    }
    
    private func loadImage() {
        imageAPIClient.loadImage(url: user?.avatarURL ?? "") { [weak self] image in
            if let image = image {
                self?.user?.image = image
                self?.view?.userLoaded(user: self?.user ?? User())
            }
        }
    }
}
