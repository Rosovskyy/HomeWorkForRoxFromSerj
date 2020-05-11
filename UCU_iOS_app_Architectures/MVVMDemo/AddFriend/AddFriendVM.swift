//
//  AddFriendVM.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

final class AddFriendVM {
    
    // MARK: - Properties
    let userAPIClient: UserAPIClient
    let imageAPIClient: ImageAPIClient
    
    var currentStepIndex: Int = 0
    
    // MARK: - Rx Properties
    var firstName = BehaviorRelay<String>(value: "")
    var lastName = BehaviorRelay<String>(value: "")
    var cityName = BehaviorRelay<String>(value: "")
    var countryName = BehaviorRelay<String>(value: "")
    var profileImage = BehaviorRelay<UIImage>(value: UIImage())
    
    let userCreated = PublishRelay<User>()
    let libraryTappedRelay = PublishRelay<Void>()
    
    // MARK: - Initialization
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()) {
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    // MARK: - Public
    func saveFriend() {
        let user = User()
        
        user.firstName = firstName.value
        user.lastName = lastName.value
        user.city = cityName.value
        user.country = countryName.value
        user.image = profileImage.value
        
        userCreated.accept(user)
    }

    func cellsCount() -> Int {
        return 3
    }
    
    // MARK: - Private
}

