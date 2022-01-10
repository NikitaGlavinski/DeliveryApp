//
//  FeturedTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit

struct FeturedTableCellModel: TableViewCompatible {
    var name: String
    var places: [PlaceModel]
    
    var reuseIdentifier: String = "FeaturedPlaces"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FeaturedPlacesTableViewCell
        cell.configureCell(with: self)
        cell.delegate = delegate
        return cell
    }
}
