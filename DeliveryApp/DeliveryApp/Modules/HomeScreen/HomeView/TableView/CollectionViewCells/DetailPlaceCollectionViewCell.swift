//
//  DetailPlaceCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

protocol DetailPlaceCollectionViewCellDelegate: AnyObject {
    func selectPlace(placeId: String)
}

class DetailPlaceCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: DetailPlaceCollectionViewCellDelegate?
    private let disposeBag = DisposeBag()
    private var placeModel: PlaceModel! {
        didSet {
            imageView.kf.setImage(with: URL(string: placeModel.images[0]), options: [])
            nameLabel.text = placeModel.name
            locationLabel.text = placeModel.location
            ratingLabel.text = String(placeModel.rating)
            timeLabel.text = "\(placeModel.deliveryTime) min"
            deliveryTypeLabel.text = placeModel.deliveryType
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryTypeLabel: UILabel!
    
    func configureCell(with model: PlaceModel) {
        placeModel = model
        setupGestures()
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [weak self] _ in
            guard let placeId = self?.placeModel.id else { return }
            self?.delegate?.selectPlace(placeId: placeId)
        }.disposed(by: disposeBag)
        contentView.addGestureRecognizer(tap)
    }
}
