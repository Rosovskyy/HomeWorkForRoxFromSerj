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
    func emptyTextFieldsErrorMessage(firstName: String?, lastName: String?, city: String?, country: String?)
    func setUser(user: User?)
    func saveData(firstName: String?, lastName: String?, city: String?, country: String?)
}

// MVP: View
// -----------------
final class MVPEditProfileViewController: UIViewController, EditViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var cityNameTextField: UITextField!
    @IBOutlet private weak var countryNameTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: MVPEditProfileViewControllerDelegate?
    private var editPresenter: EditPresenterProtocol!
    
    var user: User?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Presenter Protocol
    func showEmptyFieldsAlert(message: String) {
        let alert = UIAlertController(title: "Do you really want to save empty data?", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes, save", style: .default, handler: { action in
            self.editPresenter.saveData(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, city: self.cityNameTextField.text, country: self.countryNameTextField.text)
        }))
        alert.addAction(UIAlertAction(title: "No, go back", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    internal func saveData() {
        delegate?.editProfileViewControllerDidSave(self)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // Presenter
        editPresenter = EditPresenter(view: self)
        editPresenter.setUser(user: user)
        
        // TextFields
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        
        cityNameTextField.text = user?.city
        countryNameTextField.text = user?.country
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    // MARK: - IBActions
    @IBAction private func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveButtonDidTap() {
        editPresenter.emptyTextFieldsErrorMessage(firstName: self.firstNameTextField.text, lastName: self.lastNameTextField.text, city: self.cityNameTextField.text, country: self.countryNameTextField.text)
    }
    
    // MARK: - OBJcActions
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view?.endEditing(true)
    }
}
