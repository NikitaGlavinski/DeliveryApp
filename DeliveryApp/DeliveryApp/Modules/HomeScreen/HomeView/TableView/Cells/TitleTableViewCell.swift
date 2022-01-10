//
//  TitleTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureCell(with model: TitleCellModel) {
        titleLabel.text = model.title
    }
}
