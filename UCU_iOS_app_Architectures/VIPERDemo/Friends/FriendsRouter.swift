//
//  FriendsRouter.swift
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
protocol FriendsRouterProtocol: class {
    func openFriendDetail(user: User)
}

//
// MARK: - Router
//
final class FriendsRouter: FriendsRouterProtocol {
  
    // MARK: - Properties
    weak var viewController: UIViewController!
    
    // MARK: - Initialization
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Protocol
    func openFriendDetail(user: User) {
        let storyboard = UIStoryboard(name: "ViperStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC {
            
            vc.friend = user
            vc.modalPresentationStyle = .overFullScreen
            vc.configurator.configure(with: vc)
            
            viewController.present(vc, animated: true)
        }
    }
}
