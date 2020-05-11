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
final class ProfileRouter: ProfileRouterProtocol {
    
    // MARK: - Properties
    weak var viewController: UIViewController!
    
    // MARK: - Initialization
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Protocol
    func openEditScreen(user: User) {
        let storyboard = UIStoryboard(name: "ViperStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditVC {
            vc.user = user
            vc.delegate = viewController as? VIPEREditProfileViewControllerDelegate
            viewController.present(vc, animated: true)
        }
    }
    
    func dismissView() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
