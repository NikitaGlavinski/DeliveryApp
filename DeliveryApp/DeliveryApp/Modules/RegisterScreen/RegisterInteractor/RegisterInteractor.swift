//
//  RegisterInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import Firebase
import RxSwift

class RegisterInteractor {
    
    var authService: AuthorizationServiceProtocol!
    var secureStorage: SecureStorageServiceProtocol!
}

extension RegisterInteractor: RegisterInteractorInput {
    
    func createAccount(email: String, password: String) -> Single<String>? {
        authService.createAccount(email: email, password: password)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func saveToken(token: String) {
        secureStorage.saveToken(token: token)
    }
    
    func signInWithCredential(credential: AuthCredential) -> Single<String>? {
        authService.signInWithCredential(credential: credential)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
    
    func googleSignIn(presenting: UIViewController) -> Single<AuthCredential>? {
        authService.googleSignIn(presenting: presenting)
    }
}
