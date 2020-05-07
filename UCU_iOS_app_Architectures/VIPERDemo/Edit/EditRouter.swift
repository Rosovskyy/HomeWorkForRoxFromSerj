//
//  EditRouter.swift
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
protocol EditRouterProtocol: class {
    func dismissView()
}

//
// MARK: - Router
//
class EditRouter: EditRouterProtocol {
    
    // MARK: - Properties
    weak var viewController: EditVC!
    
    // MARK: - Initialization
    init(viewController: EditVC) {
        self.viewController = viewController
    }
    
    // MARK: - Protocol
    func dismissView() {
        viewController.dismiss(animated: true, completion: nil)
    }
}

