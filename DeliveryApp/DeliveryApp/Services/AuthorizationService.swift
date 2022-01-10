//
//  AuthorizationService.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import Firebase
import RxSwift
import GoogleSignIn

protocol AuthorizationServiceProtocol {
    func createAccount(email: String, password: String) -> Single<String>
    func emailLoginIn(email: String, password: String) -> Single<String>
    func signInWithCredential(credential: AuthCredential) -> Single<String>
    func googleSignIn(presenting: UIViewController) -> Single<AuthCredential>
}

class AuthorizationService: AuthorizationServiceProtocol {
    
    func createAccount(email: String, password: String) -> Single<String> {
        Single<String>.create { observer -> Disposable in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let token = authResult?.user.uid else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                observer(.success(token))
            }
            return Disposables.create()
        }
    }
    
    func emailLoginIn(email: String, password: String) -> Single<String> {
        Single<String>.create { observer -> Disposable in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let token = authResult?.user.uid else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                observer(.success(token))
            }
            return Disposables.create()
        }
    }
    
    func signInWithCredential(credential: AuthCredential) -> Single<String> {
        Single<String>.create { observer -> Disposable in
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let token = authResult?.user.uid else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                observer(.success(token))
            }
            return Disposables.create()
        }
    }
    
    func googleSignIn(presenting: UIViewController) -> Single<AuthCredential> {
        Single<AuthCredential>.create { observer -> Disposable in
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                observer(.failure(NetworkError.authError))
                return Disposables.create()
            }
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.signIn(with: config, presenting: presenting) { user, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard
                    let auth = user?.authentication,
                    let idToken = auth.idToken
                else {
                    observer(.failure(NetworkError.authError))
                    return
                }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: auth.accessToken)
                observer(.success(credential))
            }
            return Disposables.create()
        }
    }
}
