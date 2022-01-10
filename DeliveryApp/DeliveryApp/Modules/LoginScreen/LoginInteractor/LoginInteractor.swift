//
//  LoginInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Firebase
import RxSwift
import UIKit

class LoginInteractor {
    var authService: AuthorizationServiceProtocol!
    var secureStorage: SecureStorageService!
}

extension LoginInteractor: LoginInteractorInput {
    
    func emailLogIn(email: String, password: String) -> Single<String>? {
        authService.emailLoginIn(email: email, password: password)
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
