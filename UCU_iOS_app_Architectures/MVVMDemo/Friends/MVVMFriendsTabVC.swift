//
//  FriendsTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit
import NSObject_Rx
import MBProgressHUD

//
// MVVM: Controller
// -----------------
final class MVVMFriendsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    lazy var viewModel: MVVMFriendsViewModel = {
        return MVVMFriendsViewModel()
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        prepareBind()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendCellSegue", let indexPath = tableView.indexPathForSelectedRow {
            let friendProfileVC = segue.destination as! MVVMProfileViewController
                    
            friendProfileVC.myProfileScreen = false
            friendProfileVC.friend = viewModel.getUserByIndexPath(indexPath: indexPath)
                    
            friendProfileVC.modalPresentationStyle = .overFullScreen
        } else if segue.identifier == "addFriendSegue", let navVC = segue.destination as? UINavigationController, let addFriendVC = navVC.viewControllers.first as? AddFriendViewController {
                navVC.modalPresentationStyle = .overFullScreen
            
            addFriendVC.didUserCreated = { [weak self] user in
                self?.viewModel.addNewUser(user: user)
            }
        }
    }
    
    // MARK: - Private
    private func setupUI() {
        // View
        tableView.dataSource = self
        tableView.delegate = self
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        // Data
        viewModel.initFetch()
    }
    
    private func prepareBind() {
        viewModel.reloadTableView.bind { [weak self] _ in
            self?.tableView.reloadData()
            MBProgressHUD.hide(for: self!.view, animated: true)
        }.disposed(by: rx.disposeBag)
        
        viewModel.reloadCell.bind { [weak self] indexPath in
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }.disposed(by: rx.disposeBag)
    }
    
    // MARK: - IBActions
    @IBAction func addButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addFriendSegue", sender: self)
    }
}

//
// MARK: - VC TableViewDataSource
//
extension MVVMFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MVVMFriendTableViewCell.self, for: indexPath)
        
        let userVM = viewModel.getCellViewModel(at: indexPath)
        cell.nameLabel?.text = userVM.name
        
        if userVM.image == nil {
            viewModel.loadImage(indexPath: indexPath)
        } else {
            cell.avatarImageView.image = userVM.image
        }
        
        return cell
    }
}

//
// MARK: - VC TableViewDelegate
//
extension MVVMFriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "friendCellSegue", sender: self)
    }
}
