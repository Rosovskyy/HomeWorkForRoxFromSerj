//
//  ProfileConfigurator.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Configurator Protocol
//
protocol ProfileConfiguratorProtocol: class {
    func configure(with viewController: ProfileVC)
}

//
// MARK: - Configurator
//
final class ProfileConfigurator: ProfileConfiguratorProtocol {
    func configure(with viewController: ProfileVC) {
        let presenter = VIPERProfilePresenter(view: viewController)
        let interactor = ProfileInteractor(presenter: presenter)
        let router = ProfileRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
