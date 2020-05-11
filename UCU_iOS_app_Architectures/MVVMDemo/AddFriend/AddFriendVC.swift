//
//  AddFriendVC.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - Controller
//
final class AddFriendViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    // MARK: - Properties
    private lazy var viewModel: AddFriendVM = {
        return AddFriendVM()
    }()
    
    var didCreateUser: (( _ user: User) -> Void)?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareBind()
        setStepUI()
        prepareCollectionView()
        prepareCollectionViewLayout()
    }
    
    // MARK: - Private
    private func prepareBind() {
        viewModel.userCreated.bind { [weak self] user in
            self?.didCreateUser?(user)
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: rx.disposeBag)
    }
    
    private func setStepUI() {
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .systemBlue
        progressView.transform.scaledBy(x: 1, y: 15)
        titleLabel.textColor = UIColor.gray
        switch viewModel.currentStepIndex {
        case 0:
            progressView.setProgress(0.33, animated: true)
            titleLabel.text = "Set name"
            leftButton.setTitle("Cancel", for: .normal)
            rightButton.setTitle("Next", for: .normal)
            break
        case 1:
            progressView.setProgress(0.66, animated: true)
            titleLabel.text = "Set location"
            leftButton.setTitle("Previous", for: .normal)
            rightButton.setTitle("Next", for: .normal)
            break
        case 2:
            progressView.setProgress(1.0, animated: true)
            titleLabel.text = "Set image"
            leftButton.setTitle("Previous", for: .normal)
            rightButton.setTitle("Save", for: .normal)
            break
        default:
            break
        }
    }
    
    private func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: AddFriendFullNameScreen.id, bundle: nil), forCellWithReuseIdentifier: AddFriendFullNameScreen.id)
        collectionView.register(UINib(nibName: AddFriendLocationScreen.id, bundle: nil), forCellWithReuseIdentifier: AddFriendLocationScreen.id)
        collectionView.register(UINib(nibName: AddFriendImageScreen.id, bundle: nil), forCellWithReuseIdentifier: AddFriendImageScreen.id)
    }
    
    private func prepareCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60 - 88)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = false
    }
    
    // MARK: - IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func prevTapped(_ sender: Any) {
        switch viewModel.currentStepIndex {
        case 0:
            let alert = UIAlertController(title: "Are you sure you want to cancel?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] (_) in
                self?.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true)
            break
        case 1, 2:
            viewModel.currentStepIndex -= 1
            collectionView.selectItem(at: IndexPath(row: viewModel.currentStepIndex, section: 0), animated: true, scrollPosition: .left)
            break
        default:
            break
        }
        setStepUI()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        switch viewModel.currentStepIndex {
        case 0, 1:
            viewModel.currentStepIndex += 1
            collectionView.selectItem(at: IndexPath(row: viewModel.currentStepIndex, section: 0), animated: true, scrollPosition: .left)
            break
        case 2:
            viewModel.saveFriend()
            break
        default:
            break
        }
        setStepUI()
    }
}

//
// MARK: - CollectionView
//
extension AddFriendViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendFullNameScreen.id, for: indexPath) as! AddFriendFullNameScreen
            
            firstCell.nameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.firstName).disposed(by: rx.disposeBag)
            firstCell.lastNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.lastName).disposed(by: rx.disposeBag)
                        
            return firstCell
        } else if indexPath.row == 1 {
            let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendLocationScreen.id, for: indexPath) as! AddFriendLocationScreen
            
            secondCell.cityNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.cityName).disposed(by: rx.disposeBag)
            secondCell.countryNameTextField.rx.text.orEmpty.map { $0 }.bind(to: viewModel.countryName).disposed(by: rx.disposeBag)
                        
            return secondCell
        } else {
            let thirdCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddFriendImageScreen.id, for: indexPath) as! AddFriendImageScreen
            
            thirdCell.vc = self
            thirdCell.imageChanged.bind { [weak self] image in
                self?.viewModel.profileImage.accept(image)
            }.disposed(by: rx.disposeBag)
            
            return thirdCell
        }
    }
}
