//
//  SettingsProfileTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class SettingsProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configureCell(with model: SettingsCellModel) {
        cellImageView.image = model.image
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
}
