//
//  FriendsTabViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

//
// MVC: Controller
// -----------------
final class MVCFriendsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    // MARK: - Properties
    private let userAPIClient = UserAPIClient()
    private let imageAPIClient = ImageAPIClient()
    
    private var friends = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriends()
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let friendProfileVC = segue.destination as! MVCProfileViewController
                    
            friendProfileVC.myProfileScreen = false
            friendProfileVC.user = friends[indexPath.row]
                    
            friendProfileVC.modalPresentationStyle = .fullScreen
        }
    }

    // MARK: - Private
    private func loadFriends() {
        userAPIClient.getFriends { (users) in
            self.friends = users
        }
    }
}

//
// MARK: - VC TableViewDataSource
//
extension MVCFriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MVCFriendTableViewCell.self, for: indexPath)
        
        let user = friends[indexPath.row]
        cell.nameLabel?.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        
        if let image = user.image {
            cell.avatarImageView.image = image
        } else {
            imageAPIClient.loadImage(url: user.avatarURL) { [weak self] image in
                self?.friends[indexPath.row].image = image
                cell.avatarImageView.image = image
            }
        }
        
        return cell
    }
}

//
// MARK: - VC TableViewDelegate
//
extension MVCFriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "friendCellMVCSegue", sender: self)
    }
}
