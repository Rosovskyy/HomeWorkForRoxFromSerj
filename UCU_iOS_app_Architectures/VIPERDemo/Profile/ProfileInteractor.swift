//
//  ProfileInteractor.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Interactor Protocol
//
protocol ProfileInteractorProtocol: class {
    func getMyProfile()
    func loadImage(user: User)
}

//
// MARK: - Interactor
//
final class ProfileInteractor: ProfileInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: VIPERProfilePresenterProtocol!
    private let userAPIClient: UserAPIClient = UserAPIClient()
    private let imageAPIClient: ImageAPIClient = ImageAPIClient()
        
    // MARK: - Initialization
    required init(presenter: VIPERProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    func getMyProfile() {
        userAPIClient.getMe { [weak self] user in
            self?.loadImage(user: user)
            self?.presenter.showMyProfile(user: user)
        }
    }
    
    func loadImage(user: User) {
        imageAPIClient.loadImage(url: user.avatarURL) { [weak self] image in
            if let image = image {
                user.image = image
                self?.presenter.showMyProfile(user: user)
            }
        }
    }
}
