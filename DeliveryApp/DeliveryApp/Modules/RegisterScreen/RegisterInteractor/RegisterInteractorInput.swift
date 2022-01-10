//
//  RegisterInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import Firebase
import RxSwift

protocol RegisterInteractorInput {
    func createAccount(email: String, password: String) -> Single<String>?
    func saveToken(token: String)
    func signInWithCredential(credential: AuthCredential) -> Single<String>?
    func googleSignIn(presenting: UIViewController) -> Single<AuthCredential>?
}
