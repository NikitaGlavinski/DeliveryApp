//
//  SecureStorageService.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/21/21.
//

import Foundation

protocol SecureStorageServiceProtocol {
    func saveToken(token: String)
    func obtainToken() -> String?
    func saveOnboardingFlag()
    func obtainOnboardingFlag() -> String?
}

class SecureStorageService: SecureStorageServiceProtocol {
    
    private let storage = UserDefaults.standard
    
    func saveToken(token: String) {
        storage.setValue(token, forKey: "token")
    }
    
    func obtainToken() -> String? {
        storage.string(forKey: "token")
    }
    
    func saveOnboardingFlag() {
        storage.setValue("yes", forKey: "onBoarding")
    }
    
    func obtainOnboardingFlag() -> String? {
        storage.string(forKey: "onBoarding")
    }
}
