//
//  OrderDishTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/6/22.
//

import UIKit

class OrderDishTableViewCell: UITableViewCell {

    weak var delegate: MainTableViewDelegate!
    
    @IBAction func addOrder(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.delegate.addOrder()
            }
        }
    }
}
