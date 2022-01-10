//
//  TestTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class TestTableViewCell: UITableViewCell, Configurable {
    
    weak var delegate: MainTableViewDelegate!
    private let disposeBag = DisposeBag()
    private var placeModel: PlaceModel! {
        didSet {
            collectionView.reloadData()
            nameLabel.text = placeModel.name
            firstFoodTypeLabel.text = placeModel.foodType[0]
            secondFoodTypeLabel.text = placeModel.foodType[1]
            ratingLabel.text = String(placeModel.rating)
            timeLabel.text = "\(placeModel.deliveryTime) Min"
            priceLabel.text = ""
            for _ in 0..<placeModel.price {
                priceLabel.text! += "$"
            }
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CustomPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var firstFoodTypeLabel: UILabel!
    @IBOutlet weak var secondFoodTypeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configureCell(with model: RestaurantCellModel) {
        setupUI()
        placeModel = model.place
        collectionView.layer.cornerRadius = 20
    }
    
    private func setupUI() {
        collectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Test")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 20
        
        setupGestures()
    }
    
    private func setupGestures() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [weak self] _ in
            guard let placeId = self?.placeModel.id else { return }
            self?.delegate.selectRaw(with: placeId)
        }.disposed(by: disposeBag)
        contentView.addGestureRecognizer(tap)
    }
}

extension TestTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        placeModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Test", for: indexPath) as! TestCollectionViewCell
        cell.configureCell(with: placeModel.images[indexPath.item])
        return cell
    }
}

extension TestTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / collectionView.frame.width
        pageControl.configureView(selectedIndex: Int(index))
    }
}
