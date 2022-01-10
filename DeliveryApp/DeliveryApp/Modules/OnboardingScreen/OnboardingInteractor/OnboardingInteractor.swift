//
//  OnboardingInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation

class OnboardingInteractor {
    var secureStorage: SecureStorageServiceProtocol!
}

extension OnboardingInteractor: OnboardingInteractorInput {
    
    func saveOnboardingFlag() {
        secureStorage.saveOnboardingFlag()
    }
}
