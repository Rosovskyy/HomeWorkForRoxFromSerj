//
//  FriendsPresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 05.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Presenter Protocol
//
protocol FriendsViewProtocol: class {
    func imageLoaded(indexPath: IndexPath)
    func reloadData()
}

//
// MARK: - Presenter
//
final class FriendsPresenter: FriendsPresenterProtocol {
    
    // MARK: - Properties
    private let userAPIClient: UserAPIClient
    private let imageAPIClient: ImageAPIClient
    private weak var view: FriendsViewProtocol?
    
    private var friends: [User] = [User]()
    
    // MARK: - Initialization
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()){
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    func setViewDelegate(friendsViewProtocol: FriendsViewProtocol?) {
        self.view = friendsViewProtocol
    }
    
    // MARK: - Protocol
    func viewDidLoad() {
        getFriends()
    }
    
    func loadImage(indexPath: IndexPath) {
        imageAPIClient.loadImage(url: friends[indexPath.row].avatarURL ?? "") { [weak self] image in
            if let image = image {
                self?.friends[indexPath.row].image = image
                self?.view?.imageLoaded(indexPath: indexPath)
            }
        }
    }
    
    func getLocation(indexPath: IndexPath) -> String {
        let user = friends[indexPath.row]
        var text = ""
        if let city = user.city, let country = user.country {
            text = "  " + city + ", " + country + "  "
        } else if let city = user.city {
            text = "  " + city + "  "
        } else if let country = user.country {
            text = "  " + country + "  "
        }
        return text
    }
    
    // DataSource
    var friendsCount: Int {
        return friends.count
    }
    
    func getUserByIndexPath(indexPath: IndexPath) -> User {
        return friends[indexPath.row]
    }
    
    // MARK: - Private
    private func getFriends() {
        userAPIClient.getFriends { [weak self] friends in
            self?.friends = friends
            self?.view?.reloadData()
        }
    }
}

