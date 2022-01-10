//
//  DetailCategoriesTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/4/22.
//

import UIKit

struct DetailCategoriesTableCellModel: TableViewCompatible {
    var categories: [String]
    
    var reuseIdentifier: String = "DetailCategories"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DetailCategoriesTableViewCell
        cell.configureCell(with: self)
        cell.delegate = delegate
        return cell
    }
}
