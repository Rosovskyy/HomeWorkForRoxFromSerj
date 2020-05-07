//
//  FriendsVC.swift
//  UCU_iOS_app_Architectures
//
//  Created by Serhiy Rosovskyy on 06.05.2020.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - UIViewController
//
class FriendsVC: UIViewController, VIPERFriendsViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var presenter: VIPERFriendsPresenterProtocol!
    let configurator: FriendsConfiguratorProtocol = FriendsConfigurator()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    // MARK: - View Protocol
    func reloadTable() {
        tableView.reloadData()
    }
    
    func reloadRow(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Private
    private func setupUI() {
        
        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: FriendCell.id, bundle: nil), forCellReuseIdentifier: FriendCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }
}

//
// MARK: - TableView DataSource
//
extension FriendsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.friendsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.id, for: indexPath) as! FriendCell
        
        let user = presenter.getUserByIndexPath(indexPath: indexPath)
        cell.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        cell.locationLabel.text = presenter.getLocation(indexPath: indexPath)
        
        if let image = user.image {
            cell.avatarImageView.image = image
        } else {
            presenter.loadImageForUser(indexPath: indexPath)
        }
        
        
        return cell
    }
}

//
// MARK: - TableView Delegate
//
extension FriendsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openFriendDetail(indexPath: indexPath)
    }
}
