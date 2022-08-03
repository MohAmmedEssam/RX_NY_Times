//
//  UITableView.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import UIKit

//MARK: - UITableView Registeration
extension UITableView {
    public func register<T: UITableViewCell>(cell: T.Type) {
        if Bundle.main.path(forResource: cell.identifier, ofType: "nib") != nil{
            register(UINib(nibName: cell.identifier, bundle: nil),forCellReuseIdentifier: cell.identifier)
        }else{
            register(T.self, forCellReuseIdentifier: cell.identifier)
        }
    }
}
extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}
