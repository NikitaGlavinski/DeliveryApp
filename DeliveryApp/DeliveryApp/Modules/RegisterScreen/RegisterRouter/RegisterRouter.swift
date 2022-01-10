//
//  RegisterRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

class RegisterRouter {
    
    weak var view: UIViewController!
    
    func routeToSignIn() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .reveal
        view.navigationController?.view.layer.add(transition, forKey: nil)
        view.navigationController?.popViewController(animated: true)
    }
    
    func routeToHome() {
        let homeViewNavigation = UINavigationController(rootViewController: HomeAssembly.assemble())
        let searchNavigation = UINavigationController(rootViewController: SearchAssembly.assemble())
        searchNavigation.navigationBar.isHidden = true
        let orderNavigation = UINavigationController(rootViewController: OrderAssembly.assemble())
        orderNavigation.navigationBar.isHidden = true
        let profileNavigation = UINavigationController(rootViewController: ProfileAssembly.assemble())
        profileNavigation.navigationBar.isHidden = true
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor(red: 34/255, green: 164/255, blue: 97/255, alpha: 1)
        tabBar.setViewControllers([homeViewNavigation, searchNavigation, orderNavigation, profileNavigation], animated: true)
        view.navigationController?.setViewControllers([tabBar], animated: true)
    }
}
