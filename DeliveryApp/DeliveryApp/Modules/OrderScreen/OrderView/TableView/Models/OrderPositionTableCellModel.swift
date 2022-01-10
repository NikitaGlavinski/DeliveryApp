//
//  OrderPositionTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/6/22.
//

import UIKit

struct OrderPositionTableCellModel: TableViewCompatible {
    var title: String
    var description: String
    var count: Int
    var price: Float
    
    var reuseIdentifier: String = "OrderPosition"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! OrderPositionTableViewCell
        cell.configureCell(with: self)
        return cell
    }
    
    
}
