//
//  InfoTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit

class InfoTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configureCell(with model: InfoCellModel) {
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
}
