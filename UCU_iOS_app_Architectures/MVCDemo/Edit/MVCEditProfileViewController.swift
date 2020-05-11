//
//  EditProfileViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - EditProfileVC Delegate
//
protocol MVCEditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidSave(_ editProfileVC: MVCEditProfileViewController)
}

//
// MARK: - MVCEditProfileViewController
//
final class MVCEditProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var cityNameTextField: UITextField!
    @IBOutlet private weak var countryNameTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: MVCEditProfileViewControllerDelegate?
    private var user: User?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Public
    func setUser(user: User?) {
        self.user = user
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // TextFields
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        
        cityNameTextField.text = user?.city
        countryNameTextField.text = user?.country
        
        // Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func emptyTextFieldsErrorMessage() -> String? { // TextFields validations
        var emptyValues = [String]()
        let fieldsString = [firstNameTextField.id, lastNameTextField.id, cityNameTextField.id, countryNameTextField.id]
        for (index, textField) in [firstNameTextField, lastNameTextField, cityNameTextField, countryNameTextField].enumerated() {
            if let trimmed = textField?.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), trimmed.isEmpty {
                emptyValues.append(fieldsString[index])
            }
        }
        
        if emptyValues.isEmpty {
            return nil
        } else {
            let equalOne = emptyValues.count == 1
            let message = "Input \(equalOne ? "field" : "fields") \(emptyValues) \(equalOne ? "is" : "are") empty"
            return message
        }
    }
    
    private func showEmptyFieldsAlert(message: String) {
        let alert = UIAlertController(title: "Do you really want to save empty data?", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes, save", style: .default, handler: { action in
            self.saveData()
        }))
        alert.addAction(UIAlertAction(title: "No, go back", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    private func saveData() {
        user?.firstName = firstNameTextField.text
        user?.lastName = lastNameTextField.text
        
        user?.city = cityNameTextField.text
        user?.country = countryNameTextField.text
        
        delegate?.editProfileViewControllerDidSave(self)
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - IBActions
    @IBAction private func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveButtonDidTap() {
        if let message = emptyTextFieldsErrorMessage() {
            showEmptyFieldsAlert(message: message)
        } else {
            saveData()
        }
    }
    
    // MARK: - OBJcActions
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view?.endEditing(true)
    }
}
