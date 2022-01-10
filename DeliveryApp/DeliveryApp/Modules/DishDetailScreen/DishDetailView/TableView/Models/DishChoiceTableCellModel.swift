//
//  DishChoiceTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit

struct DishChoiceTableCellModel: TableViewCompatible {
    var name: String
    var isSelected: Bool
    
    var reuseIdentifier: String = "DishChoice"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DishChoiceTableViewCell
        cell.configureCell(with: self)
        return cell
    }
}
