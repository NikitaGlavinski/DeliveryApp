//
//  DetailTitleTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import UIKit

class DetailTitleTableViewCell: UITableViewCell, Configurable {
    
    private var takeAwayIsSelected: Bool = false {
        didSet {
            takeAwayButton.tintColor = takeAwayIsSelected ? .white : UIColor(red: 34/255, green: 164/255, blue: 93/255, alpha: 1)
            takeAwayButton.backgroundColor = takeAwayIsSelected ? UIColor(red: 34/255, green: 164/255, blue: 93/255, alpha: 1) : .white
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var firstFoodTypeLabel: UILabel!
    @IBOutlet weak var secondFoodTypeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var takeAwayButton: UIButton!
    
    func configureCell(with model: DetailTitleTableCellModel) {
        nameLabel.text = model.title
        firstFoodTypeLabel.text = model.foodType[0]
        secondFoodTypeLabel.text = model.foodType[1]
        ratingLabel.text = "\(model.rating)"
        timeLabel.text = "\(model.deliveryTime)"
        priceLabel.text = ""
        for _ in 0..<model.priceRange {
            priceLabel.text = (priceLabel.text ?? "") + "$"
        }
        
        takeAwayButton.layer.borderWidth = 1
        takeAwayButton.layer.borderColor = UIColor(red: 34/255, green: 164/255, blue: 93/255, alpha: 1).cgColor
    }
    
    @IBAction func takeAwayTapped(_ sender: Any) {
        takeAwayIsSelected.toggle()
    }
}
