//
//  ProfilePresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

class ProfilePresenter {
    
    weak var view: ProfileViewInput!
    var interactor: ProfileInteractorInput!
    var router: ProfileRouter!
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
}
