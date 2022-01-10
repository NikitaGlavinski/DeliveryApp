//
//  TestCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit
import Kingfisher

class TestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(with imageURL: String) {
        imageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "foodPlaceholder"), options: [.cacheMemoryOnly])
    }
}
