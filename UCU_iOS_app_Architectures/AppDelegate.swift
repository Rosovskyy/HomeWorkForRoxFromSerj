//
//  AppDelegate.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/21/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
        
        return true
    }
}

