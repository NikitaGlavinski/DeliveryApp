//
//  DetailCategoriesTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/4/22.
//

import UIKit

class DetailCategoriesTableViewCell: UITableViewCell, Configurable {
    
    weak var delegate: MainTableViewDelegate!
    private var selectedCategoryIndex: Int = 0
    private var categoriesModel: DetailCategoriesTableCellModel! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func configureCell(with model: DetailCategoriesTableCellModel) {
        setupUI()
        categoriesModel = model
    }
    
    private func setupUI() {
        collectionView.register(UINib(nibName: "DetailCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCategory")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DetailCategoriesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCategory", for: indexPath) as! DetailCategoriesCollectionViewCell
        cell.configureCell(with: categoriesModel.categories[indexPath.item], isSelected: indexPath.item == selectedCategoryIndex, index: indexPath.item)
        cell.delegate = self
        return cell
    }
}

extension DetailCategoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = categoriesModel.categories[indexPath.item].width(height: 30, font: UIFont.systemFont(ofSize: 19, weight: .medium))
        return CGSize(width: width, height: 30)
    }
}

extension DetailCategoriesTableViewCell: DetailCategoriesCollectionViewCellDelegate {
    
    func selectCategory(category: String, index: Int) {
        selectedCategoryIndex = index
        collectionView.reloadData()
        delegate.selectCategory(category: category)
    }
}
