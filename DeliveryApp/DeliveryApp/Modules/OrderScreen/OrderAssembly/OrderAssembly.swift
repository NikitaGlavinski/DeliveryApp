//
//  OrderAssembly.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class OrderAssembly {
    
    static func assemble() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "Order") as! OrderViewController
        let presenter = OrderPresenter()
        let interactor = OrderInterctor()
        let router = OrderRouter()
        
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
