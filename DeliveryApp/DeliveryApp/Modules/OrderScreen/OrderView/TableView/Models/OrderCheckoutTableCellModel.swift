//
//  OrderCheckoutTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/6/22.
//

import UIKit

struct OrderCheckoutTableCellModel: TableViewCompatible {
    var subTotal: Float
    var delivery: Float
    var total: Float
    
    var reuseIdentifier: String = "OrderCheckout"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! OrderCheckoutTableViewCell
        cell.configureCell(with: self)
        cell.delegate = delegate
        return cell
    }
    
    
}
