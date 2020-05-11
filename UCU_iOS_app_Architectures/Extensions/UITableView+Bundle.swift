//
//  UITableView+Bundle.swift
//  UsefulTricks
//
//  Created by Roxane Gud on 2/7/19.
//  Copyright © 2019 Roxane Markhyvka. All rights reserved.
//

import UIKit

extension UITableView {
    /// Convenient func to register UITableViewCell subclass by it's type.
    /// Note: this func uses type name as a nib file name string and reuseIdentifier string, so all three namings should match!
    /// E.g. class name `SomeTableViewCell`, nib name `SomeTableViewCell.xib`, reuse identifier string `SomeTableViewCell`
    public func register(_ cellClass: UITableViewCell.Type) {
        let className = String(describing: cellClass)
        let nib = UINib(nibName: className, bundle: Bundle(for: cellClass.self))

        register(nib, forCellReuseIdentifier: className)
    }

    /// Convenient func to dequeue UITableViewCell subclass by it's type.
    /// Note: this func uses type name as a  reuseIdentifier string, so both namings should match!
    /// E.g. class name `SomeTableViewCell`, reuse identifier string `SomeTableViewCell`
    public func dequeue<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}

