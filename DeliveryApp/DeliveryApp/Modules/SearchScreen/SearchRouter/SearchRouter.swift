//
//  SearchRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit

class SearchRouter {
    
    weak var view: UIViewController!
    
    func routeToDetailPlace(placeId: String) {
        let detailView = PlaceDetailAssembly.assemble(placeId: placeId)
        view.navigationController?.pushViewController(detailView, animated: true)
    }
}
