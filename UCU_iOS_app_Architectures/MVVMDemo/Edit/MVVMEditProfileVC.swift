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
protocol MVVMEditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidSave(_ editProfileVC: MVVMEditProfileViewController)
}

//
// MARK: - Controller
//
class MVVMEditProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var countryNameTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: MVVMEditProfileViewControllerDelegate?
    var user: User? = nil
    
    lazy var viewModel: EditVM = {
        return EditVM()
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        prepareBind()
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // TextFields
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        
        cityNameTextField.text = user?.city
        countryNameTextField.text = user?.country
        
        // Gestures
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // Data
    }
    
    private func prepareBind() {
        firstNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.firstName).disposed(by: rx.disposeBag)
        lastNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.lastName).disposed(by: rx.disposeBag)
        cityNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.city).disposed(by: rx.disposeBag)
        countryNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.country).disposed(by: rx.disposeBag)
    }
    
    private func showEmptyFieldsAlert(message: String) {
        let alert = UIAlertController(title: "Do you really want to save empty data?", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes, save", style: .default, handler: { action in
            self.saveData()
        }))
        alert.addAction(UIAlertAction(title: "No, go back", style: .cancel, handler: nil))

        self.present(alert, animated: true)
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
        if let message = viewModel.checkTextFields() {
            showEmptyFieldsAlert(message: message)
        } else {
            saveData()
        }
    }
    
    // MARK: - OBJCActions
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view?.endEditing(true)
    }
}
