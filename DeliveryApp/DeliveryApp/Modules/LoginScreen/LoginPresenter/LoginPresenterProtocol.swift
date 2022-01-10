//
//  LoginPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

protocol LoginPresenterProtocol: AnyObject {
    func createAccount()
    func emailLogIn(email: String, password: String)
    func googleSignIn(presenting: UIViewController)
    func faceBookSignIn(token: String)
}
