//
//  RegisterPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

protocol RegisterPresenterProtocol: AnyObject {
    func signIn()
    func createAccount(email: String, password: String)
    func googleSignIn(presenting: UIViewController)
    func faceBookSignIn(token: String)
}
