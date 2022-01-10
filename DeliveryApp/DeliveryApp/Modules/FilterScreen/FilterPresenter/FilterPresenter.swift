//
//  FilterPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import Foundation
import RxSwift

class FilterPresenter {
    
    weak var view: FilterViewInput!
    var interactor: FilterInteractorInput!
    var router: FilterRouter!
    
    private let disposeBag = DisposeBag()
    
}

extension FilterPresenter: FilterPresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        var categories: [FiltersModel]!
        var dietary: [FiltersModel]!
        guard
            let filterObtainer = interactor.getFilters(),
            let priceFilterObtainer = interactor.getPriceFilters()
        else { return }
        filterObtainer
            .flatMap { filters -> Single<[PriceFilter]> in
                categories = filters.filter({!$0.isDietary})
                dietary = filters.filter({$0.isDietary})
                return priceFilterObtainer
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] filters in
                self?.view.hideLoader()
                self?.view.setupFilters(categories: categories, dietary: dietary, priceFilters: filters)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func updateFilter(filter: FiltersModel) {
        view.showLoader()
        guard let filterUpdater = interactor.setFilter(filter: filter) else { return }
        filterUpdater
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                print(complete)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func clearAllCategoriesFilters() {
        self.view.showLoader()
        guard let clearer = interactor.clearAllCategoriesFilters(isDeitery: false) else { return }
        clearer
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                print(complete)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func clearAllDietaryFilters() {
        self.view.showLoader()
        guard let clearer = interactor.clearAllCategoriesFilters(isDeitery: true) else { return }
        clearer
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                print(complete)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func updatePriceFilter(filter: PriceFilter) {
        self.view.showLoader()
        guard let filterUpdater = interactor.setPriceFilter(filter: filter) else { return }
        filterUpdater
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                print(complete)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func clearAllPriceFilters() {
        self.view.showLoader()
        guard let clearer = interactor.clearAllPriceFilters() else { return }
        clearer
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] complete in
                self?.view.hideLoader()
                print(complete)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}
