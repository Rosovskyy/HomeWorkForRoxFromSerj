//
//  FriendsConfigurator.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Protocol
//
protocol FriendsConfiguratorProtocol: class {
    func configure(with viewController: FriendsVC)
}

//
// MARK: - Configurator
//
class FriendsConfigurator: FriendsConfiguratorProtocol {
    func configure(with viewController: FriendsVC) {
        let presenter = VIPERFriendsPresenter(view: viewController)
        let interactor = FriendsInteractor(presenter: presenter)
        let router = FriendsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
