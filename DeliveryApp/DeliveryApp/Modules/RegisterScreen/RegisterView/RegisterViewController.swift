//
//  RegisterViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import RxSwift
import RxCocoa
import FBSDKLoginKit

class RegisterViewController: BaseViewController {
    
    var presenter: RegisterPresenterProtocol!
    
    private let disposeBag = DisposeBag()
    
    private lazy var facebookButton: FBLoginButton = {
        let button = FBLoginButton()
        button.delegate = self
        return button
    }()
    
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(appearKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
    }
    
    private func setupGestures() {
        let mainTap = UITapGestureRecognizer()
        mainTap.rx.event.bind(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
        view.addGestureRecognizer(mainTap)
    }
    
    private func checkCredentials() {
        var animations = [() -> ()]()
        var hideAnimations = [() -> ()]()
        
        var correctCredentials = true
        
        animations.append(nameTextField.textField.text?.isEmpty == true ?
                          addAnimation(textField: nameTextField, label: nameLabel) :
                          addCorrectAnimation(textField: nameTextField, label: nameLabel))
        hideAnimations.append(addHideAnimation(textField: nameTextField, label: nameLabel))
        correctCredentials = nameTextField.textField.text?.isEmpty == true ? false : true
        
        animations.append(emailTextField.textField.text?.isEmpty == true ?
                          addAnimation(textField: emailTextField, label: emailLabel) :
                          addCorrectAnimation(textField: emailTextField, label: emailLabel))
        hideAnimations.append(addHideAnimation(textField: emailTextField, label: emailLabel))
        correctCredentials = emailTextField.textField.text?.isEmpty == true ? false : true
        
        animations.append(passwordTextField.textField.text?.isEmpty == true ?
                          addAnimation(textField: passwordTextField, label: passwordLabel) :
                          addCorrectAnimation(textField: passwordTextField, label: passwordLabel))
        hideAnimations.append(addHideAnimation(textField: passwordTextField, label: passwordLabel))
        correctCredentials = passwordTextField.textField.text?.isEmpty == true ? false : true
        
        animations.append((confirmPasswordTextField.textField.text?.isEmpty == true) || (confirmPasswordTextField.textField.text != passwordTextField.textField.text) ?
                          addAnimation(textField: confirmPasswordTextField, label: confirmPasswordLabel) :
                          addCorrectAnimation(textField: confirmPasswordTextField, label: confirmPasswordLabel))
        hideAnimations.append(addHideAnimation(textField: confirmPasswordTextField, label: confirmPasswordLabel))
        correctCredentials = (confirmPasswordTextField.textField.text?.isEmpty == true) || (confirmPasswordTextField.textField.text != passwordTextField.textField.text) ? false : true
        
        if correctCredentials {
            presenter.createAccount(email: emailTextField.textField.text ?? "", password: passwordTextField.textField.text ?? "")
        } else {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut) {
                for animation in animations {
                    animation()
                }
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 1) {
                    for hideAnimation in hideAnimations {
                        hideAnimation()
                    }
                }
            }
        }
    }
    
    private func addAnimation(textField: CustomTextField, label: UILabel) -> (() -> ()) {
        textField.frame.origin.x -= 15
        return {
            textField.frame.origin.x += 15
            label.alpha = 1.0
            textField.subviews.first?.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    private func addCorrectAnimation(textField: CustomTextField, label: UILabel) -> (() -> ()) {
        {
            textField.subviews.first?.layer.borderColor = UIColor.systemGreen.cgColor
        }
    }
    
    private func addHideAnimation(textField: CustomTextField, label: UILabel) -> (() -> ()) {
        {
            label.alpha = 0.0
            textField.subviews.first?.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBAction func emailSignUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.checkCredentials()
            }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        presenter.signIn()
    }
    
    @IBAction func facebookSignIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.facebookButton.sendActions(for: .touchUpInside)
            }
        }
    }
    
    @IBAction func googleSignIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.presenter.googleSignIn(presenting: self)
            }
        }
    }
    
    @objc private func appearKeyboard(_ notification: Notification) {
        let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        var target = view.frame
        target.size.height = UIScreen.main.bounds.height - keyboardRect.height
        target.origin.y = -scrollView.contentOffset.y + 150 + keyboardRect.height
        scrollView.scrollRectToVisible(target, animated: true)
    }
}

extension RegisterViewController: RegisterViewInput {
    
}

extension RegisterViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            showError(error: error)
            return
        }
        guard let token = AccessToken.current?.tokenString else { return }
        presenter.faceBookSignIn(token: token)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}
