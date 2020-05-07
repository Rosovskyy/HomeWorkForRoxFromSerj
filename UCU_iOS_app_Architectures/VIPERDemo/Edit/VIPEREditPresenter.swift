//
//  VIPEREditPresenter.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

//
// MARK: - Presenter Protocol
//
protocol VIPEREditPresenterProtocol: class {
    var router: EditRouterProtocol! { set get }
    func configureView(user: User)
    func cancelTapped()
    func saveTapped(textFieldsData: [String?])
}

//
// MARK: - View Protocol
//
protocol VIPEREditViewProtocol: class {
    func showEmptyFieldsAlert(message: String)
    func saveUserData()
}

//
// MARK: - Presenter
//
class VIPEREditPresenter: VIPEREditPresenterProtocol {
    
    // MARK: - Properties
    weak var view: VIPEREditViewProtocol!
    var interactor: EditInteractorProtocol!
    var router: EditRouterProtocol!
    
    var user: User?
    
    // MARK: - Initialization
    required init(view: VIPEREditViewProtocol) {
        self.view = view
    }
    
    // MARK: - Protocol
    func configureView(user: User) {
        self.user = user
    }
    
    func cancelTapped() {
        router.dismissView()
    }
    
    func saveTapped(textFieldsData: [String?]) {
        if let message = checkTextFields(textFieldsData: textFieldsData) {
            view.showEmptyFieldsAlert(message: message)
        } else {
            view.saveUserData()
        }
    }
    
    // MARK: - Private
    private func checkTextFields(textFieldsData: [String?]) -> String? {
        var emptyValues = [String]()
        let fieldsString = ["FirstName", "LastName", "CityName", "CountryName"]
        for (index, text) in textFieldsData.enumerated() {
            if let trimmed = text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), trimmed.isEmpty {
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

