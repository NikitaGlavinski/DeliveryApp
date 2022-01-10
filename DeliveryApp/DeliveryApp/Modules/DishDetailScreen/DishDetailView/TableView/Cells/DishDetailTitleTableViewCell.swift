//
//  DishDetailTitleTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit

class DishDetailTitleTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceTypeLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    
    func configureCell(with model: DishDetailTitleCellModel) {
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        foodTypeLabel.text = model.foodType
        priceTypeLabel.text = ""
        for _ in 0..<model.priceType {
            priceTypeLabel.text = (priceTypeLabel.text ?? "") + "$"
        }
    }
}
