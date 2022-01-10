//
//  OrderDishTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/6/22.
//

import UIKit

struct OrderDishTableCellModel: TableViewCompatible {
    var reuseIdentifier: String = "OrderDish"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! OrderDishTableViewCell
        cell.delegate = delegate
        return cell
    }
}
