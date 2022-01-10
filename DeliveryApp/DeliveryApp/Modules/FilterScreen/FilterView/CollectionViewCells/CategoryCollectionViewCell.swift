//
//  CollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol CategoryCollectionViewCellDelegate: AnyObject {
    func updateFilter(filter: FiltersModel)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let disposeBag = DisposeBag()
    weak var delegate: CategoryCollectionViewCellDelegate!
    
    private var filterModel: FiltersModel! {
        didSet {
            if filterModel.isSelected {
                contentView.backgroundColor = UIColor(red: 34/255, green: 164/255, blue: 93/255, alpha: 1)
                label.textColor = .white
            } else {
                contentView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
                label.textColor = UIColor(red: 112/255, green: 119/255, blue: 115/255, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    func configureCell(with model: FiltersModel) {
        self.filterModel = model
        label.text = model.name.uppercased()
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowColor = UIColor.darkGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1, height: 3)
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOpacity = 0.3
        self.clipsToBounds = false
        self.layer.cornerRadius = 5
        
        addGestures()
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [weak self] _ in
            self?.filterModel.isSelected.toggle()
            guard let model = self?.filterModel else { return }
            self?.delegate.updateFilter(filter: model)
        }.disposed(by: disposeBag)
        contentView.addGestureRecognizer(tap)
    }
}
