//
//  FeaturedItemsCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import UIKit

struct DetailFeaturedItemsCellModel: TableViewCompatible {
    var dishes: [DishesModel]
    
    var reuseIdentifier: String = "DetailFeature"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FeaturedItemsTableViewCell
        cell.configureCell(with: self)
        cell.delegate = delegate
        return cell
    }
    
    
}
