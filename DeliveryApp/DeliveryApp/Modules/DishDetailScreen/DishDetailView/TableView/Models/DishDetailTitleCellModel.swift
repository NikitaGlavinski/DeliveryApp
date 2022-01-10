//
//  DishDetailTitleCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit

struct DishDetailTitleCellModel: TableViewCompatible {
    
    var name: String
    var description: String
    var foodType: String
    var priceType: Int
    
    var reuseIdentifier: String = "DishDetailTitle"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DishDetailTitleTableViewCell
        cell.configureCell(with: self)
        return cell
    }
}
