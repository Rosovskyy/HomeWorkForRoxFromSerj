//
//  EditProfileViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - EditVC Delegate
//
protocol MVPEditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidSave(_ editProfileVC: MVPEditProfileViewController)
}

//
// MARK: - Presenter Protocol
//
protocol EditPresenterProtocol {
    func checkTextFields(textFieldsData: [String?]) -> String?
}

// MVP: View
// -----------------
class MVPEditProfileViewController: UIViewController, EditViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var countryNameTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: MVPEditProfileViewControllerDelegate?
    private let editPresenter = EditPresenter()
    
    var user: User? = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Presenter Protocol
    func showEmptyFieldsAlert(message: String) {
        let alert = UIAlertController(title: "Do you really want to save empty data?", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes, save", style: .default, handler: { action in
            self.saveData()
        }))
        alert.addAction(UIAlertAction(title: "No, go back", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // Presenter
        editPresenter.setViewDelegate(editViewProtocol: self)
        
        // TextFields
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        
        cityNameTextField.text = user?.city
        countryNameTextField.text = user?.country
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
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
        let textFieldsData = [firstNameTextField.text, lastNameTextField.text, cityNameTextField.text, countryNameTextField.text]
        if let message = editPresenter.checkTextFields(textFieldsData: textFieldsData) {
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
