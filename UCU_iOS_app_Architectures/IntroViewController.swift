//
//  IntroViewController.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/21/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import UIKit

protocol IntroMenuOptionsDataSource {
    typealias Item = IntroOptionsMenuItem
    
    var count: Int { get }
    func get(at index: Int) -> Item?
}

final class IntroViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            tableView.tableFooterView = UIView() // removing the residual bottom cells
        }
    }
    
    private let optionsMenu: IntroMenuOptionsDataSource = IntroOptionsMenu()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

// MARK: - Options menu DataSource and Delegate
extension IntroViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        
        if let option = optionsMenu.get(at: indexPath.row) {
            cell.textLabel?.text = option.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let option = optionsMenu.get(at: indexPath.row) {
            show(menuOption: option)
            tableView.deselectRow(at: indexPath, animated: true
            )
        }
    }
}

// MARK: - Navigation
private extension IntroViewController {
    private func show(menuOption: IntroOptionsMenu.Item) {
        let rootVC = IntroMenuOptionsControllerFactory.rootViewController(for: menuOption)
        rootVC.modalPresentationStyle = .overFullScreen
        
        present(rootVC, animated: true, completion: nil)
    }
}


