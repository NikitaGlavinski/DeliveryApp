//
//  PlaceDetailPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation
import RxSwift

class PlaceDetailPresenter {
    weak var view: PlaceDetailViewInput!
    var interactor: PlaceDetailInteractorInput!
    var router: PlaceDetailRouter!
    
    private let disposeBag = DisposeBag()
    private var placeModel: PlaceModel!
    private var dishModels: [DishesModel]!
    private var filteredDishModels: [DishesModel]?
    
    var placeId: String
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    private func setupCellModels(isUpdate: Bool = false) {
        var cellModels = [TableViewCompatible]()
        cellModels.append(DetailTitleTableCellModel(title: placeModel.name, priceRange: placeModel.price, foodType: placeModel.foodType, rating: placeModel.rating, deliveryTime: placeModel.deliveryTime))
        cellModels.append(DetailFeaturedItemsCellModel(dishes: dishModels))
        cellModels.append(DetailCategoriesTableCellModel(categories: placeModel.categories))
        for dish in filteredDishModels ?? [] {
            cellModels.append(DetailDishTableCellModel(dish: dish))
        }
        guard isUpdate else {
            view.setupTableView(models: cellModels)
            return
        }
        view.updateTableView(models: cellModels, fromIndex: 3, toIndex: 3 + dishModels.count)
    }
}

extension PlaceDetailPresenter: PlaceDetailPresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        guard
            let placeObtainer = interactor.getPlace(placeId: placeId),
            let dishesObtainer = interactor.getDishes(placeId: placeId)
        else { return }
        placeObtainer
            .flatMap({ [weak self] place -> Single<[DishesModel]> in
                self?.placeModel = place
                return dishesObtainer
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] dishes in
                self?.dishModels = dishes
                self?.filteredDishModels = dishes
                self?.view.hideLoader()
                self?.setupCellModels()
            }, onFailure: { [weak self] error in
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func filterDishes(by category: String) {
        guard category == "Most Populars" else {
            filteredDishModels = dishModels.filter({$0.foodType.contains(category)})
            setupCellModels(isUpdate: true)
            return
        }
        filteredDishModels = dishModels
        setupCellModels(isUpdate: true)
    }
    
    func showDishDetail(dishId: Int) {
        router.routeToDishDetail(dishId: dishId, placeId: placeId)
    }
}
