//
//  DishDetailRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit

class DishDetailRouter {
    weak var view: UIViewController!
    
    func dismissView() {
        view.dismiss(animated: true, completion: nil)
    }
}
