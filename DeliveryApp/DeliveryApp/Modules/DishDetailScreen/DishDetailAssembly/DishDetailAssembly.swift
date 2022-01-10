//
//  DishDetailAssembly.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit

class DishDetailAssembly {
    
    static func assemble(dishId: Int, placeId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "DishDetail") as! DishDetailViewController
        let presenter = DishDetailPresenter(dishId: dishId, placeId: placeId)
        let interactor = DishDetailInteractor()
        let router = DishDetailRouter()
        
        let firebaseService: FirebaseService? = ServiceLocator.shared.getService()
        let secureStorage: SecureStorageService? = ServiceLocator.shared.getService()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.firebaseService = firebaseService
        interactor.secureStorage = secureStorage
        router.view = view
        
        return view
    }
}
