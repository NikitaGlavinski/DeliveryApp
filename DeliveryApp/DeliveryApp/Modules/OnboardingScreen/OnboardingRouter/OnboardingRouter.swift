//
//  OnboardingRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

class OnboardingRouter {
    weak var view: UIViewController!
    
    func routeToAuth() {
        let authView = LoginAssembly.assemble()
        view.navigationController?.setViewControllers([authView], animated: true)
    }
}
