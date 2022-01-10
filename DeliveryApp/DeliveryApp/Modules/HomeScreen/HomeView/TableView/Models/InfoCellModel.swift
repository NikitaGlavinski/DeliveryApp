//
//  InfoCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit

struct InfoCellModel: TableViewCompatible {
    var title = "Free Delivery for 1 Month!"
    var subTitle = "You've to order at least $10 for using free delivery for 1 month."
    
    var reuseIdentifier: String = "Info"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! InfoTableViewCell
        cell.configureCell(with: self)
        return cell
    }
    
    
}
