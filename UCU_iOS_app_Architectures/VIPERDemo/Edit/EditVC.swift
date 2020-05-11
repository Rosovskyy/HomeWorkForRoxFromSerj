//
//  EditVC.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - EditVC Delegate
//
protocol VIPEREditProfileViewControllerDelegate: class {
    func editProfileViewControllerDidSave(_ editProfileVC: EditVC)
}

//
// MARK: - UIViewController
//
final class EditVC: UIViewController, VIPEREditViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var cityNameTextField: UITextField!
    @IBOutlet private weak var countryNameTextField: UITextField!
    
    // MARK: - Properties
    weak var delegate: VIPEREditProfileViewControllerDelegate?
    var presenter: VIPEREditPresenterProtocol!
    let configurator: EditConfiguratorProtocol = EditConfigurator()
    
    var user: User?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(with: self)
        if let user = user {
            presenter.configureView(user: user)
            setupUI()
        }
    }
    
    // MARK: - View Protocol
    func showEmptyFieldsAlert(message: String) {
        let alert = UIAlertController(title: "Do you really want to save empty data?", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes, save", style: .default, handler: { action in
            self.saveUserData()
        }))
        alert.addAction(UIAlertAction(title: "No, go back", style: .cancel, handler: nil))

        present(alert, animated: true)
    }
    
    func saveUserData() {
        user?.firstName = firstNameTextField.text
        user?.lastName = lastNameTextField.text
        user?.city = cityNameTextField.text
        user?.country = countryNameTextField.text
        
        delegate?.editProfileViewControllerDidSave(self)
        
        presenter.cancelTapped()
    }
    
    // MARK: - Private
    private func setupUI() {
        firstNameTextField.text = user?.firstName
        lastNameTextField.text = user?.lastName
        cityNameTextField.text = user?.city
        countryNameTextField.text = user?.country
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        presenter.cancelTapped()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let textFieldsData = [firstNameTextField.text, lastNameTextField.text, cityNameTextField.text, countryNameTextField.text]
        presenter.saveTapped(textFieldsData: textFieldsData)
    }
}
