//
//  EditConfigurator.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Configurator Protocol
//
protocol EditConfiguratorProtocol: class {
    func configure(with viewController: EditVC)
}

//
// MARK: - Configurator
//
final class EditConfigurator: EditConfiguratorProtocol {
    func configure(with viewController: EditVC) {
        let presenter = VIPEREditPresenter(view: viewController)
        let interactor = EditInteractor(presenter: presenter)
        let router = EditRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}

