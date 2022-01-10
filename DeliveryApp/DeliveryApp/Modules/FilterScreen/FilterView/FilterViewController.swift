//
//  FilterViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import UIKit

class FilterViewController: BaseViewController {
    
    var presenter: FilterPresenterProtocol!
    private var categoriesModels = [FiltersModel]() {
        didSet {
            categoriesCollectionView.reloadData()
        }
    }
    
    private var dietaryModels = [FiltersModel]() {
        didSet {
            dietaryCollectionView.reloadData()
        }
    }
    
    private var priceModels = [PriceFilter]() {
        didSet {
            priceFilterCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dietaryCollectionView: UICollectionView!
    @IBOutlet weak var dietaryCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var priceFilterCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let categoriesLayout = LeftAlignedCollectionViewFlowLayout()
        categoriesLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        categoriesCollectionView.collectionViewLayout = categoriesLayout
        categoriesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        let dietaryLayout = LeftAlignedCollectionViewFlowLayout()
        dietaryLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        dietaryCollectionView.collectionViewLayout = dietaryLayout 
        dietaryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        dietaryCollectionView.dataSource = self
        dietaryCollectionView.delegate = self
        
        priceFilterCollectionView.dataSource = self
        priceFilterCollectionView.delegate = self
        
        navigationController?.navigationBar.tintColor = UIColor(red: 34/255, green: 164/255, blue: 93/255, alpha: 1)
    }
    
    private func setupLayout() {
        updateCategoriesHeight()
        updateDietaryHeight()
        updateScrollContentSize()
    }
    
    private func updateCategoriesHeight() {
        var totalItemsWidth: CGFloat = 0
        for item in categoriesModels {
            totalItemsWidth += item.name.width(height: 40, font: UIFont.systemFont(ofSize: 15, weight: .regular)) + 50 + 30
        }
        let numberOfRows = totalItemsWidth / (UIScreen.main.bounds.width - 40)
        let roundValue = numberOfRows.rounded(.up)
        let height = roundValue * 55
        categoriesCollectionViewHeight.constant = height
    }
    
    private func updateDietaryHeight() {
        var totalItemsWidth: CGFloat = 0
        for item in dietaryModels {
            totalItemsWidth += item.name.width(height: 40, font: UIFont.systemFont(ofSize: 15, weight: .regular)) + 50 + 30
        }
        let numberOfRows = totalItemsWidth / (UIScreen.main.bounds.width - 40)
        let roundValue = numberOfRows.rounded(.up)
        let height = roundValue * 55
        dietaryCollectionViewHeight.constant = height
    }
    
    private func updateScrollContentSize() {
        let contentChangeHeight = (categoriesCollectionViewHeight.constant - 260) + (dietaryCollectionViewHeight.constant - 150)
        scrollView.contentSize.height += contentChangeHeight
    }
    
    @IBAction func clearAllTapped(_ sender: Any) {
        for index in 0..<categoriesModels.count {
            categoriesModels[index].isSelected = false
        }
        presenter.clearAllCategoriesFilters()
    }
    
    @IBAction func clearAllDietaryTapped(_ sender: Any) {
        for index in 0..<dietaryModels.count {
            dietaryModels[index].isSelected = false
        }
        presenter.clearAllDietaryFilters()
    }
    
    @IBAction func clearAllPriceTapped(_ sender: Any) {
        for index in 0..<priceModels.count {
            priceModels[index].isSelected = false
        }
        presenter.clearAllPriceFilters()
    }
}

extension FilterViewController: FilterViewInput {
    
    func setupFilters(categories: [FiltersModel], dietary: [FiltersModel], priceFilters: [PriceFilter]) {
        categoriesModels = categories
        dietaryModels = dietary
        priceModels = priceFilters
        setupLayout()
    }
}

extension FilterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == priceFilterCollectionView {
            return priceModels.count
        } else {
            return collectionView == categoriesCollectionView ? categoriesModels.count : dietaryModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == priceFilterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceFilter", for: indexPath) as! PriceCollectionViewCell
            cell.configureCell(with: priceModels[indexPath.item])
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! CategoryCollectionViewCell
            let model = collectionView == categoriesCollectionView ? categoriesModels[indexPath.item] : dietaryModels[indexPath.item]
            cell.configureCell(with: model)
            cell.delegate = self
            return cell
        }
    }
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == priceFilterCollectionView {
            return CGSize(width: 70, height: 70)
        } else {
            let models = collectionView == categoriesCollectionView ? categoriesModels : dietaryModels
            let textWidth = models[indexPath.item].name.width(height: 40, font: UIFont.systemFont(ofSize: 15, weight: .regular))
            return CGSize(width: textWidth + 50, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == priceFilterCollectionView ? 20 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == priceFilterCollectionView ? 0 : 15
    }
}


extension FilterViewController: CategoryCollectionViewCellDelegate, PriceCollectionViewCellDelegate {
    func updatePriceFilter(filter: PriceFilter) {
        presenter.updatePriceFilter(filter: filter)
    }
    
    func updateFilter(filter: FiltersModel) {
        presenter.updateFilter(filter: filter)
    }
}
