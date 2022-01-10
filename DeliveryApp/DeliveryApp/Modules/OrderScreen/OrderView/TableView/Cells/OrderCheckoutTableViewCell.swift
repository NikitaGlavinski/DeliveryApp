//
//  OrderCheckoutTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/6/22.
//

import UIKit

class OrderCheckoutTableViewCell: UITableViewCell, Configurable {

    weak var delegate: MainTableViewDelegate!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    func configureCell(with model: OrderCheckoutTableCellModel) {
        subTotalLabel.text = "$\(model.subTotal)"
        totalLabel.text = "$\(model.total)"
        checkoutButton.setTitle("CHECKOUT ($\(model.total))", for: .normal)
    }
    
    @IBAction func checkoutTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.delegate.checkoutOrder()
            }
        }
    }
}
