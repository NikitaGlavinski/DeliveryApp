//
//  HomeRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

class HomeRouter {
    weak var view: UIViewController!
    
    func showFilters() {
        let filterView = FilterAssembly.assemble()
        view.navigationController?.pushViewController(filterView, animated: true)
    }
    
    func routeToDetailPlace(placeId: String) {
        let detailView = PlaceDetailAssembly.assemble(placeId: placeId)
        view.navigationController?.pushViewController(detailView, animated: true)
    }
}
