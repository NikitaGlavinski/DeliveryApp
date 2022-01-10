//
//  FeaturedPlacesTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit

class FeaturedPlacesTableViewCell: UITableViewCell, Configurable {
    
    private var placeModels = [PlaceModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    weak var delegate: MainTableViewDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureCell(with model: FeturedTableCellModel) {
        setupUI()
        nameLabel.text = model.name
        placeModels = model.places
    }
}

extension FeaturedPlacesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailPlace", for: indexPath) as! DetailPlaceCollectionViewCell
        cell.configureCell(with: placeModels[indexPath.item])
        cell.delegate = self
        return cell
    }
    
}

extension FeaturedPlacesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 1.8), height: collectionView.frame.height)
    }
}

extension FeaturedPlacesTableViewCell: DetailPlaceCollectionViewCellDelegate {
    
    func selectPlace(placeId: String) {
        delegate?.selectRaw(with: placeId)
    }
}
