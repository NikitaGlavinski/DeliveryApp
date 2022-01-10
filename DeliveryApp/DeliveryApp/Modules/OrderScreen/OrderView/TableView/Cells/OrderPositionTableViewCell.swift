//
//  OrderPositionTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/6/22.
//

import UIKit

class OrderPositionTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(with model: OrderPositionTableCellModel) {
        setupUI()
        countLabel.text = "\(model.count)"
        titleLabel.text = model.title
        priceLabel.text = "USD\(model.price)"
        descriptionLabel.text = model.description
    }
    
    private func setupUI() {
        countView.layer.borderWidth = 1
        countView.layer.borderColor = UIColor.lightGray.cgColor
        countView.layer.cornerRadius = 5
    }
}
