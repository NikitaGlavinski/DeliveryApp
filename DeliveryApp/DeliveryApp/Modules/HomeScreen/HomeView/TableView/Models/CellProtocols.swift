//
//  CellProtocols.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit

protocol Configurable {
    associatedtype T
    func configureCell(with model: T)
}

protocol TableViewCompatible {
    var reuseIdentifier: String { get }
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell
}

protocol MainTableViewDelegate: AnyObject {
    func selectRaw(with id: String)
    func selectCategory(category: String)
    func addOrder()
    func checkoutOrder()
    func selectDish(with id: Int)
}

extension MainTableViewDelegate {
    func selectRaw(with id: String) {}
    
    func selectCategory(category: String) {}
    
    func addOrder() {}
    
    func checkoutOrder() {}
    
    func selectDish(with id: Int) {}
}
