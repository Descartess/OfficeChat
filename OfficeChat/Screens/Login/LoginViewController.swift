//
//  LoginViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 09/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AlertReasons: Error {
    case invalidEmail
    case passwordTooShort
    case invalidCredentials
    case custom
}

class LoginViewController: UIViewController {
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func signInButton(_ sender: Any) {
        
        guard
            let vm = viewModel,
            let input = validateInput()
        else { return }
        
        vm.signInUser(email: input.email, password: input.password) { result in
            if !result {
                self.showAlert(type: .invalidCredentials)
            } else {
                self.authenticationCoordinatorDelegate?.didLogin()
            }
        }
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard
            let vm = viewModel,
            let input = validateInput()
        else { return }
        vm.createUser(email: input.email, password: input.password) { result in
            if !result {
                self.showAlert(type: .invalidCredentials)
            } else {
                self.authenticationCoordinatorDelegate?.didCreateNewUser()
            }
        }
    }
    
    var authenticationCoordinatorDelegate: AuthenticationCoordinatorDelegate?
    
    var viewModel: LoginViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func setUpViews() {
        emailField.layer.cornerRadius = 32
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOpacity = 0.2
        emailField.layer.shadowOffset = CGSize.zero
        emailField.layer.shadowRadius = 10
        
        passwordField.layer.cornerRadius = 32
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOpacity = 0.2
        passwordField.layer.shadowOffset = CGSize.zero
        passwordField.layer.shadowRadius = 10
        
        signIn.layer.cornerRadius = 27
        signUp.layer.cornerRadius = 27
    }
    
    func validateInput() -> (email:String, password: String)? {
        guard
            let vm = viewModel,
            let email = emailField.text,
            vm.checkValidEmail(email)
            else { showAlert(type: .invalidEmail);return nil}
        
        guard
            let password = passwordField.text,
            vm.checkPasswordLength(password)
            else { showAlert(type: .passwordTooShort);return nil }
        return (email, password)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        emailField.delegate = self
        passwordField.delegate = self
        emailField.text = nil
        passwordField.text = nil
    }
    
    func bindViewModel() {

    }
    
    func showAlert(type: AlertReasons) {
        var message = ""
        switch type {
        case .invalidCredentials:
            message = "Invalid Credentials"
        case .invalidEmail:
            message = "Invalid Email"
        case .passwordTooShort:
            message = "Password too short"
        case .custom:
            message = "custom"
        }
        
        let alertController = UIAlertController(title: "Alert",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
