//
//  HomePresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation
import RxSwift

class HomePresenter {
    weak var view: HomeViewInput!
    var router: HomeRouter!
    var interactor: HomeInteractorInput!
    
    private let disposeBag = DisposeBag()
    
    private var placeModels: [PlaceModel] = [PlaceModel]()
    
    private func filterPlaceModels(with selectedFilters: [FiltersModel]) {
        if selectedFilters.count == 0 {
            return
        }
        placeModels = placeModels.filter({ placeModel in
            for filter in selectedFilters {
                if placeModel.foodType.contains(filter.name) {
                    return true
                }
            }
            return false
        })
    }
    
    private func filterPlaceModelsBy(price filters: [PriceFilter]) {
        if filters.count == 0 {
            return
        }
        placeModels = placeModels.filter({ placeModel in
            for filter in filters {
                if placeModel.price == filter.value {
                    return true
                }
            }
            return false
        })
    }
    
    private func setupTableView() {
        var cellModels = [TableViewCompatible]()
        guard let place = placeModels.first else {
            view.setupTableView(models: [])
            return
        }
        cellModels.append(FirstPlaceTableCellModel(placeId: place.id, images: place.images))
        cellModels.append(FeturedTableCellModel(name: "Featured Partners", places: placeModels))
        cellModels.append(InfoCellModel())
        cellModels.append(FeturedTableCellModel(name: "Best Pick", places: placeModels))
        cellModels.append(TitleCellModel(title: "All Restaurants"))
        for onePlace in placeModels {
            cellModels.append(RestaurantCellModel(place: onePlace))
        }
        view.setupTableView(models: cellModels)
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        var selectedFilters: [FiltersModel]!
        guard
            let placesGetter = interactor.getPlaces(),
            let filtersObtainer = interactor.getFilters(),
            let priceFilterObtainer = interactor.getPriceFilters()
        else { return }
        placesGetter
            .flatMap { [weak self] places -> Single<[FiltersModel]> in
                self?.placeModels = places
                return filtersObtainer
            }
            .flatMap({ filters -> Single<[PriceFilter]> in
                selectedFilters = filters.filter({$0.isSelected})
                return priceFilterObtainer
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] filters in
                let selectedPriceFilters = filters.filter({$0.isSelected})
                self?.filterPlaceModels(with: selectedFilters)
                self?.filterPlaceModelsBy(price: selectedPriceFilters)
                self?.view.hideLoader()
                self?.setupTableView()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func showFilters() {
        router.showFilters()
    }
    
    func showDetailPlace(placeId: String) {
        router.routeToDetailPlace(placeId: placeId)
    }
}
