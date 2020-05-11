//
//  MVVMFriendsViewModel.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 05.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import NSObject_Rx

final class MVVMFriendsViewModel {
    
    // MARK: - Properties
    let userAPIClient: UserAPIClient
    let imageAPIClient: ImageAPIClient
    
    private var users: [User] = [User]()
    private var cellViewModels: [MVVMFriendCellViewModel] = [MVVMFriendCellViewModel]()
    
    // MARK: - Rx Properties
    let reloadTableView = PublishRelay<Void>()
    let reloadCell = PublishRelay<IndexPath>()
    
    // MARK: - Initialization
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()) {
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    // MARK: - Public
    func initFetch() {
        userAPIClient.getFriends { [weak self] users in
            self?.processFetchesUsers(users: users)
        }
    }
    
    func cellsCount() -> Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MVVMFriendCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(user: User) -> MVVMFriendCellViewModel {
        let fullName = (user.firstName ?? "") + " " + (user.lastName ?? "")
        let joinedString = JoinedString()
        let location = joinedString.append(user.city).append(user.country).result
        return MVVMFriendCellViewModel(name: fullName,
                                       imageURL: user.avatarURL,
                                       location: location,
                                       image: user.image)
    }
    
    func loadImage(indexPath: IndexPath) {
        imageAPIClient.loadImage(url: self.cellViewModels[indexPath.row].imageURL) { image in
            self.cellViewModels[indexPath.row].image = image
            self.users[indexPath.row].image = image
            self.reloadCell.accept(indexPath)
        }
    }
    
    func getUserImage(indexPath: IndexPath) -> UIImage? {
        if let image = users[indexPath.row].image {
            return image
        } else {
            loadImage(indexPath: indexPath)
            return nil
        }
    }
    
    func getUserByIndexPath(indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }
    
    func addNewUser(user: User) {
        users.insert(user, at: 0)
        cellViewModels.insert(createCellViewModel(user: user), at: 0)
        reloadTableView.accept(())
    }
    
    // MARK: - Private
    private func processFetchesUsers(users: [User]) {
        self.users = users
        var vms = [MVVMFriendCellViewModel]()
        for user in users {
            vms.append(createCellViewModel(user: user))
        }
        self.cellViewModels = vms
        self.reloadTableView.accept(())
    }
}
