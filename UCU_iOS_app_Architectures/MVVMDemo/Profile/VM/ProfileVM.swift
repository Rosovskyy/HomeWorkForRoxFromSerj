//
//  ProfileVM.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 05.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import NSObject_Rx

final class ProfileVM {
    
    // MARK: - Properties
    let userAPIClient: UserAPIClient
    let imageAPIClient: ImageAPIClient
    
    // MARK: - Rx Properties
    let user = BehaviorRelay<User>(value: User())
    let profileImage = PublishRelay<UIImage>()
    
    // MARK: - Initialization
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()) {
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    // MARK: - Public
    func initFetch() {
        userAPIClient.getMe { [weak self] user in
            self?.user.accept(user)
        }
    }
    
    func loadImage() {
        imageAPIClient.loadImage(url: self.user.value.avatarURL) { image in
            if let image = image {
                self.profileImage.accept(image)
            }
        }
    }
}

