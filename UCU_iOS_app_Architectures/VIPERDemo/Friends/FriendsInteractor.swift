//
//  FriendsInteractor.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Interactor Protocol
//
protocol FriendsInteractorProtocol: class {
    func getFriends()
    func loadImage(user: User, indexPath: IndexPath)
}

//
// MARK: - Interactor
//
final class FriendsInteractor: FriendsInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: VIPERFriendsPresenterProtocol!
    private let userAPIClient: UserAPIClient = UserAPIClient()
    private let imageAPIClient: ImageAPIClient = ImageAPIClient()
    
    // MARK: - Initialization
    required init(presenter: VIPERFriendsPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Protocol
    func getFriends() {
        userAPIClient.getFriends { [weak self] friends in
            self?.presenter.displayFriends(friends: friends)
        }
    }
    
    func loadImage(user: User, indexPath: IndexPath) {
        imageAPIClient.loadImage(url: user.avatarURL ?? "") { [weak self] image in
            if let image = image {
                user.image = image
                self?.presenter.imageLoaded(user: user, indexPath: indexPath)
            }
        }
    }
}
