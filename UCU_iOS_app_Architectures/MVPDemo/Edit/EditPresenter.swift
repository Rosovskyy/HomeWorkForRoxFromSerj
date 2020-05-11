//
//  EditPresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Presenter Delegate
protocol EditViewProtocol: class {
    func showEmptyFieldsAlert(message: String)
    func saveData()
}

//
// MARK: - Presenter
final class EditPresenter: EditPresenterProtocol {
    
    // MARK: - Properties
    private let userAPIClient: UserAPIClient
    private let imageAPIClient: ImageAPIClient
    private weak var view: EditViewProtocol?
    
    private var user: User?
    
    // MARK: - Initialization
    init(view: EditViewProtocol?, userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()){
        self.view = view
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    // MARK: - Protocol
    func emptyTextFieldsErrorMessage(firstName: String?, lastName: String?, city: String?, country: String?) {
        var emptyValues = [String]()
        let fieldsString = ["FirstName", "LastName", "CityName", "CountryName"]
        for (index, text) in [firstName, lastName, city, country].enumerated() {
            if let trimmed = text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), trimmed.isEmpty {
                emptyValues.append(fieldsString[index])
            }
        }
        
        if !emptyValues.isEmpty {
            let equalOne = emptyValues.count == 1
            let message = "Input \(equalOne ? "field" : "fields") \(emptyValues) \(equalOne ? "is" : "are") empty"
            view?.showEmptyFieldsAlert(message: message)
        } else {
            saveData(firstName: firstName, lastName: lastName, city: city, country: country)
        }
    }
    
    func setUser(user: User?) {
        self.user = user
    }
    
    func saveData(firstName: String?, lastName: String?, city: String?, country: String?) {
        user?.firstName = firstName
        user?.lastName = lastName
        user?.city = city
        user?.country = country
        
        view?.saveData()
    }
}
