//
//  VIPERProfilePresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Presenter Protocol
//
protocol VIPERProfilePresenterProtocol: class {
    var router: ProfileRouterProtocol! { set get }
    func configureView(user: User?)
    func editButtonTapped()
    func showMyProfile(user: User)
    func cancelTapped()
    func loadImage(user: User)
}

//
// MARK: - View Protocol
//
protocol VIPERProfileViewProtocol: class {
    func setUserData(user: User)
    func setFriendView()
}

//
// MARK: - Presenter
//
class VIPERProfilePresenter: VIPERProfilePresenterProtocol {
    
    // MARK: - Properties
    weak var view: VIPERProfileViewProtocol!
    var interactor: ProfileInteractorProtocol!
    var router: ProfileRouterProtocol!
    private var user: User? = User()
    
    // MARK: - Initialization
    required init(view: VIPERProfileViewProtocol) {
        self.view = view
    }
    
    // MARK: - Protocol
    func configureView(user: User?) {
        if let user = user {
            showMyProfile(user: user)
            view.setFriendView()
        } else {
            interactor.getMyProfile()
        }
    }
    
    func editButtonTapped() {
        if let user = user {
            router.openEditScreen(user: user)
        }
    }
    
    func showMyProfile(user: User) {
        self.user = user
        self.view.setUserData(user: user)
    }
    
    func cancelTapped() {
        router.dismissView()
    }
    
    func loadImage(user: User) {
        interactor.loadImage(user: user)
    }
}
