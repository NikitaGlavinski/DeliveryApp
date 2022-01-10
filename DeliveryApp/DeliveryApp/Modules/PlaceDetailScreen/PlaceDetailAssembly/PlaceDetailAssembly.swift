//
//  PlaceDetailAssembly.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class PlaceDetailAssembly {
    
    static func assemble(placeId: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "PlaceDetail") as! PlaceDetailViewController
        let presenter = PlaceDetailPresenter(placeId: placeId)
        let interactor = PlaceDetailInteractor()
        let router = PlaceDetailRouter()
        
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
