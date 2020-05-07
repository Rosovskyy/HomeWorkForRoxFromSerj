//
//  Dispatch+Delay.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

protocol Delayable {
    func delay(closure: @escaping ()->())
}

extension Delayable {
    func delay(closure: @escaping ()->()) {
        let randomDelay = Double.random(in: 0...2.0)
        
        let when = DispatchTime.now() + randomDelay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
