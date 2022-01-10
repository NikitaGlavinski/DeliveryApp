//
//  RegisterPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import RxSwift
import Firebase

class RegisterPresenter {
    
    weak var view: RegisterViewInput!
    var interactor: RegisterInteractorInput!
    var router: RegisterRouter!
    
    private let disposeBag = DisposeBag()
    
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func signIn() {
        router.routeToSignIn()
    }
    
    func createAccount(email: String, password: String) {
        view.showLoader()
        guard let accountCreator = interactor.createAccount(email: email, password: password) else { return }
        accountCreator
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] token in
                self?.interactor.saveToken(token: token)
                self?.view.hideLoader()
                self?.router.routeToHome()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func googleSignIn(presenting: UIViewController) {
        view.showLoader()
        guard let googleSignIn = interactor.googleSignIn(presenting: presenting) else { return }
        googleSignIn
            .flatMap { [weak self] credential -> Single<String> in
                guard let credSignIn = self?.interactor.signInWithCredential(credential: credential) else {
                    self?.view.hideLoader()
                    return Single<String>.error(NetworkError.authError)
                }
                return credSignIn
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] token in
                self?.interactor.saveToken(token: token)
                self?.view.hideLoader()
                self?.router.routeToHome()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
    
    func faceBookSignIn(token: String) {
        view.showLoader()
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        guard let signIn = interactor.signInWithCredential(credential: credential) else { return }
        signIn
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] authToken in
                self?.view.hideLoader()
                self?.interactor.saveToken(token: authToken)
                self?.router.routeToHome()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}
