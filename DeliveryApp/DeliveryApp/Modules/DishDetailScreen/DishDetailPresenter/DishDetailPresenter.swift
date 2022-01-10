//
//  DishDetailPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import Foundation
import RxSwift

class DishDetailPresenter {
    weak var view: DishDetailViewInput!
    var interactor: DishDetailInteractorInput!
    var router: DishDetailRouter!
    
    private let disposeBag = DisposeBag()
    private var selectedChoice: Int = 0
    private var dishModel: DishesModel!
    var placeId: String
    var dishId: Int
    
    init(dishId: Int, placeId: String) {
        self.dishId = dishId
        self.placeId = placeId
    }
    
    private func setupTableView() {
        var cellModels = [TableViewCompatible]()
        cellModels.append(DishDetailTitleCellModel(
            name: dishModel.name,
            description: dishModel.description,
            foodType: dishModel.foodType[0],
            priceType: dishModel.priceType
        ))
        for (index, choice) in dishModel.choices.enumerated() {
            cellModels.append(DishChoiceTableCellModel(name: choice, isSelected: index == selectedChoice))
        }
        cellModels.append(OrderDishTableCellModel())
        view.setupTableView(cellModels: cellModels, imageURL: dishModel.image)
    }
}

extension DishDetailPresenter: DishDetailPresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        guard let dishObtainer = interactor.obtainDish(dishId: dishId, placeId: placeId) else { return }
        dishObtainer
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] dish in
                self?.view.hideLoader()
                self?.dishModel = dish
                self?.setupTableView()
            }, onFailure: { [weak self] error in
                self?.view.showLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func selectChoice(with name: String) {
        guard let index = dishModel.choices.firstIndex(where: {$0 == name}) else { return }
        selectedChoice = index
        setupTableView()
    }
    
    func closeView() {
        router.dismissView()
    }
    
    func setDishOrder() {
        view.showLoader()
        guard let orderSetter = interactor.setDishOrder(dish: dishModel) else { return }
        orderSetter
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                self?.closeView()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}
