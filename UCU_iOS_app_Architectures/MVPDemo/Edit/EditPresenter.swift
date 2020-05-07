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
    init(userAPIClient: UserAPIClient = UserAPIClient(), imageAPIClient: ImageAPIClient = ImageAPIClient()){
        self.userAPIClient = userAPIClient
        self.imageAPIClient = imageAPIClient
    }
    
    func setViewDelegate(editViewProtocol: EditViewProtocol?) {
        self.view = editViewProtocol
    }
    
    // MARK: - Protocol
    func checkTextFields(textFieldsData: [String?]) -> String? {
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
