//
//  SearchPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import Foundation
import RxSwift

class SearchPresenter {
    
    weak var view: SearchViewInput!
    var router: SearchRouter!
    var interactor: SearchInteractorInput!
    
    private let disposeBag = DisposeBag()
    private var places = [PlaceModel]()
}

extension SearchPresenter: SearchPresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        guard let placesGetter = interactor.getPlaces() else { return }
        placesGetter
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] places in
                self?.places = places
                self?.view.hideLoader()
                let cellModels = places.compactMap({RestaurantCellModel(place: $0)})
                self?.view.setupTableView(places: cellModels)
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func filterPlaces(with text: String) {
        let filteredPlaces = places.filter({$0.name.lowercased().hasPrefix(text.lowercased())})
        let cellModels = filteredPlaces.compactMap({RestaurantCellModel(place: $0)})
        view.setupTableView(places: cellModels)
    }
    
    func showPlaceDetail(placeId: String) {
        router.routeToDetailPlace(placeId: placeId)
    }
}
