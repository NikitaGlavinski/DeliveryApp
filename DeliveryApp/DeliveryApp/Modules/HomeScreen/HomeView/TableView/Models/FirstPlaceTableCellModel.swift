//
//  FirstPlaceTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit

struct FirstPlaceTableCellModel: TableViewCompatible {
    var placeId: String
    var images: [String]
    
    var reuseIdentifier: String = "FirstPlace"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FirstPlaceTableViewCell
        cell.delegate = delegate
        cell.configureCell(with: self)
        return cell
    }
}
