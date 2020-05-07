//
//  IntroMenuOptionsControllerFactory.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

final class IntroMenuOptionsControllerFactory {
    
    static func rootViewController(for menuOption: IntroOptionsMenuItem) -> UIViewController {
        switch menuOption {
        case .mvc: return mvcDemoRootController
        case .mvp: return mvpDemoRootController
        case .mvvm: return mvvmDemoRootController
        case .viper: return viperDemoRootController
        }
    }
    
    // MARK: private
    static private var mvcDemoRootController: UIViewController {
        return UIStoryboard.named("MVCDemo").viewController("MVCTabBarController")
    }
    static private var mvpDemoRootController: UIViewController {
        return UIStoryboard.named("MVPDemo").viewController("MVPTabBarController")
    }
    static private var mvvmDemoRootController: UIViewController {
        return UIStoryboard.named("MVVMDemo").viewController("MVVMTabBarController")
    }
    static private var viperDemoRootController: UIViewController {
        return UIStoryboard.named("ViperStoryboard").viewController("ViperTabBarController")
    }
}

private extension UIStoryboard {
    static func named(_ storyboardName: String) -> UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    func viewController(_ identifier: String) -> UIViewController {
        return instantiateViewController(withIdentifier: identifier)
    }
}
