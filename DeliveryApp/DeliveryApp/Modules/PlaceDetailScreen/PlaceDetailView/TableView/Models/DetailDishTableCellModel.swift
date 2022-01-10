//
//  DetailDishTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/4/22.
//

import UIKit

struct DetailDishTableCellModel: TableViewCompatible {
    var dish: DishesModel
    
    var reuseIdentifier: String = "DetailDish"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DetailDishTableViewCell
        cell.configureCell(with: self)
        return cell
    }
}
