//
//  DetailDishTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/4/22.
//

import UIKit
import Kingfisher

class DetailDishTableViewCell: UITableViewCell, Configurable {
    
    private var dishModel: DishesModel! {
        didSet {
            dishImageView.kf.setImage(with: URL(string: dishModel.image), placeholder: UIImage(named: "foodPlaceholder"), options: [.cacheMemoryOnly])
            nameLabel.text = dishModel.name
            descriptionLabel.text = dishModel.description
            foodTypeLabel.text = dishModel.foodType[0]
            priceLabel.text = "USD\(dishModel.price)"
            priceTypeLabel.text = ""
            for _ in 0..<dishModel.priceType {
                priceTypeLabel.text = (priceTypeLabel.text ?? "") + "$"
            }
        }
    }

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceTypeLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureCell(with model: DetailDishTableCellModel) {
        dishModel = model.dish
    }
}
