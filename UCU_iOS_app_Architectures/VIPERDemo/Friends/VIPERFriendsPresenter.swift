//
//  VIPERFriendsPresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Presenter protocol
//
protocol VIPERFriendsPresenterProtocol: class {
    var router: FriendsRouterProtocol! { set get }
    func configureView()
    func displayFriends(friends: [User])
    func imageLoaded(user: User, indexPath: IndexPath)
    
    var friendsCount: Int { get }
    func getUserByIndexPath(indexPath: IndexPath) -> User
    func loadImageForUser(indexPath: IndexPath)
    func openFriendDetail(indexPath: IndexPath)
}

//
// MARK: - View Protocol
//
protocol VIPERFriendsViewProtocol: class {
    func reloadTable()
    func reloadRow(indexPath: IndexPath)
}

//
// MARK: - Presenter
//
class VIPERFriendsPresenter: VIPERFriendsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: VIPERFriendsViewProtocol!
    var interactor: FriendsInteractorProtocol!
    var router: FriendsRouterProtocol!
    
    private var friends: [User] = [User]()
        
    // MARK: - Initialization
    required init(view: VIPERFriendsViewProtocol) {
        self.view = view
    }
    
    // MARK: - Protocol
    func configureView() {
        getFriends()
    }
    
    func displayFriends(friends: [User]) {
        self.friends = friends
        self.view.reloadTable()
    }
    
    func imageLoaded(user: User, indexPath: IndexPath) {
        friends[indexPath.row] = user
        view.reloadRow(indexPath: indexPath)
    }
    
    var friendsCount: Int {
        return friends.count
    }
    
    func getUserByIndexPath(indexPath: IndexPath) -> User {
        return friends[indexPath.row]
    }
    
    func loadImageForUser(indexPath: IndexPath) {
        interactor.loadImage(user: friends[indexPath.row], indexPath: indexPath)
    }
    
    func openFriendDetail(indexPath: IndexPath) {
        router.openFriendDetail(user: friends[indexPath.row])
    }
    
    // MARK: - Private
    private func getFriends() {
        interactor.getFriends()
    }
}
