//
//  TitleCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit

struct TitleCellModel: TableViewCompatible {
    var title: String
    
    var reuseIdentifier: String = "Title"
    
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! TitleTableViewCell
        cell.configureCell(with: self)
        return cell
    }
}
