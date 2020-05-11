//
//  EditInteractor.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Interactor Protocol
//
protocol EditInteractorProtocol: class {
    
}

//
// MARK: - Interactor
//
final class EditInteractor: EditInteractorProtocol {
    
    // MARK: - Properties
    weak var presenter: VIPEREditPresenterProtocol!
    private let userAPIClient: UserAPIClient = UserAPIClient()
    private let imageAPIClient: ImageAPIClient = ImageAPIClient()
    
    private var user: User?
    
    // MARK: - Initialization
    required init(presenter: VIPEREditPresenterProtocol) {
        self.presenter = presenter
    }
}

