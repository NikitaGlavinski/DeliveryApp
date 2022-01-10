//
//  FeatureItemCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import UIKit
import Kingfisher
import RxSwift

protocol FeatureItemCollectionViewCellDelegate: AnyObject {
    func selectDish(with id: Int)
}

class FeatureItemCollectionViewCell: UICollectionViewCell {
    
    private let disposeBag = DisposeBag()
    weak var delegate: FeatureItemCollectionViewCellDelegate!
    private var dishesModel: DishesModel! {
        didSet {
            imageView.kf.setImage(with: URL(string: dishesModel.image), placeholder: UIImage(named: "foodPlaceholder"), options: [.cacheMemoryOnly])
            nameLabel.text = dishesModel.name
            foodTypeLabel.text = dishesModel.foodType[0]
            priceLabel.text = ""
            for _ in 0..<dishesModel.priceType {
                priceLabel.text = (priceLabel.text ?? "") + "$"
            }
        }
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    
    func configureCell(with model: DishesModel) {
        dishesModel = model
        addGestures()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [weak self] _ in
            guard let dishId = self?.dishesModel.id else { return }
            self?.delegate.selectDish(with: dishId)
        }.disposed(by: disposeBag)
        contentView.addGestureRecognizer(tap)
    }
}
