//
//  FilterAssembly.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import UIKit

class FilterAssembly {
    
    static func assemble() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "Filter") as! FilterViewController
        let presenter = FilterPresenter()
        let interactor = FilterInteractor()
        let router = FilterRouter()
        
        let firebaseService: FirebaseService? = ServiceLocator.shared.getService()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.firebaseService = firebaseService
        router.view = view
        
        return view
    }
}
