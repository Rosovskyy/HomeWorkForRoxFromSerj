//
//  FriendsTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MARK: - Presenter Protocol
//
protocol FriendsPresenterProtocol {
    // Life Cycle
    func viewDidLoad()
    
    func getLocation(indexPath: IndexPath) -> String
    
    // DataSource
    var friendsCount: Int { get }
    func getUserByIndexPath(indexPath: IndexPath) -> User
}

// MVP: View
// -----------------
final class MVPFriendsViewController: UIViewController, FriendsViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private let friendsPresenter = FriendsPresenter()
    private var friends = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        friendsPresenter.setViewDelegate(friendsViewProtocol: self)
        friendsPresenter.viewDidLoad()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let friendProfileVC = segue.destination as! MVPProfileViewController
                    
            friendProfileVC.myProfileScreen = false
            friendProfileVC.user = friendsPresenter.getUserByIndexPath(indexPath: indexPath)
                    
            friendProfileVC.modalPresentationStyle = .fullScreen
        }
    }
    
    // MARK: - Presenter Protocol
    func imageLoaded(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func reloadData() {
        tableView.reloadData()
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
extension MVPFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsPresenter.friendsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.id, for: indexPath) as! FriendCell
        
        let user = friendsPresenter.getUserByIndexPath(indexPath: indexPath)
        cell.nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        cell.locationLabel.text = friendsPresenter.getLocation(indexPath: indexPath)
        
        if let image = user.image {
            cell.avatarImageView.image = image
        } else {
            friendsPresenter.loadImage(indexPath: indexPath)
        }
        
        
        return cell
    }
}

//
// MARK: - TableView Delegate
//
extension MVPFriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "friendsMVPSegue", sender: self)
    }
}
