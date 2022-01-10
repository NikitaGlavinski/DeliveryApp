//
//  DetailTitleTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import UIKit

struct DetailTitleTableCellModel: TableViewCompatible {
    var title: String
    var priceRange: Int
    var foodType: [String]
    var rating: Float
    var deliveryTime: Int
    
    var reuseIdentifier: String = "DetailTitle"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! DetailTitleTableViewCell
        cell.configureCell(with: self)
        return cell
    }
}
