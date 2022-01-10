//
//  RestaurantCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit

struct RestaurantCellModel: TableViewCompatible {
    
    var place: PlaceModel
    
    var reuseIdentifier: String = "Test"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! TestTableViewCell
        cell.configureCell(with: self)
        cell.delegate = delegate
        return cell
    }
}
