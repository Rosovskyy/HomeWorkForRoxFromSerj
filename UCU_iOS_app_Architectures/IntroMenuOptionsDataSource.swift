//
//  IntroMenuOptionsDataSource.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/21/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

enum IntroOptionsMenuItem {
    case mvc
    case mvp
    case mvvm
    case viper
}

extension IntroOptionsMenuItem {
    var title: String {
        
        switch self {
        case .mvc: return "MVC"
        case .mvp: return "MVP"
        case .mvvm: return "MVVM"
        case .viper: return "VIPER"
        }
    }
}

final class IntroOptionsMenu: IntroMenuOptionsDataSource {
    private let items: [Item] = [.mvc, .mvp, .mvvm, .viper]
        
    var count: Int {
        return items.count
    }
    
    func get(at index: Int) -> Item? {
        guard index >= 0, index < items.count else { return nil }
        
        return items[index]
    }
}

