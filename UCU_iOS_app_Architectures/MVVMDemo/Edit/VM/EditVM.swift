//
//  EditVM.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 05.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import NSObject_Rx

//
// MARK: - ViewModel
//
final class EditVM {
    
    // MARK: - Properties
    let userAPIClient: UserAPIClient
    let imageAPIClient: ImageAPIClient
    
    // MARK: - Rx Properties
    var firstName = BehaviorRelay<String>(value: "")
    var lastName = BehaviorRelay<String>(value: "")
    var city = BehaviorRelay<String>(value: "")
    var country = BehaviorRelay<String>(value: "")
    
    // MARK: - Initialization
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()) {
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    // MARK: - Public
    func checkTextFields() -> String? {
        var emptyValues = [String]()
        let fieldsString = ["FirstName", "LastName", "CityName", "CountryName"]
        for (index, text) in [firstName, lastName, city, country].enumerated() {
            let trimmed = text.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if trimmed.isEmpty {
                emptyValues.append(fieldsString[index])
            }
        }
        
        let equalOne = emptyValues.count == 1
        let message = "Input \(equalOne ? "field" : "fields") \(emptyValues) \(equalOne ? "is" : "are") empty"
        if emptyValues.isEmpty {
            return nil
        } else {
            return message
        }
    }
}
