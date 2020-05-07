//
//  ProfileRouter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: - Router Protocol
//
protocol ProfileRouterProtocol: class {
    func openEditScreen(user: User)
    func dismissView()
}

//
// MARK: - Router
//
class ProfileRouter: ProfileRouterProtocol {
    
    // MARK: - Properties
    weak var viewController: ProfileVC!
    
    // MARK: - Initialization
    init(viewController: ProfileVC) {
        self.viewController = viewController
    }
    
    // MARK: - Protocol
    func openEditScreen(user: User) {
        let storyboard = UIStoryboard(name: "ViperStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditVC {
            vc.user = user
            vc.delegate = viewController
            viewController.present(vc, animated: true)
        }
    }
    
    func dismissView() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
