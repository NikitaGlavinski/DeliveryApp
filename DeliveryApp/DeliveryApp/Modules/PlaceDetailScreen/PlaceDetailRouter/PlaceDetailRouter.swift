//
//  PlaceDetailRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class PlaceDetailRouter {
    weak var view: UIViewController!
    
    func routeToDishDetail(dishId: Int, placeId: String) {
        let dishDetailView = DishDetailAssembly.assemble(dishId: dishId, placeId: placeId)
        dishDetailView.modalPresentationStyle = .fullScreen
        view.present(dishDetailView, animated: true, completion: nil)
    }
}
