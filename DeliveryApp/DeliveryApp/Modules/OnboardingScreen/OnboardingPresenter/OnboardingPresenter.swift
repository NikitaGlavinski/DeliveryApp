//
//  OnboardingPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation

class OnboardingPresenter {
    weak var view: OnboardingViewInput!
    var interactor: OnboardingInteractorInput!
    var router: OnboardingRouter!
}

extension OnboardingPresenter: OnboardingPresenterProtocol {
    
    func endOnboarding() {
        interactor.saveOnboardingFlag()
        router.routeToAuth()
    }
}
