//
//  AuthenticationCoordinator.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func didCreateNewUser()
    func didLogin()
}

class AuthenticationCoordinator : Coordinator {
    var loginViewController: LoginViewController?
    var profileCoordinator: ProfileCoordinator?
    var mainScreenCoordinator: MainScreenCoordinator?
    let presenter: UIWindow
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    func start() {
        guard
            let loginViewController = LoginViewController.instantiate(from: .main)
        else  { return }
        self.loginViewController = loginViewController
        self.loginViewController?.authenticationCoordinatorDelegate = self
        self.loginViewController?.viewModel = LoginViewModel()
        presenter.rootViewController = loginViewController
        presenter.makeKeyAndVisible()
    }
}

extension AuthenticationCoordinator: AuthenticationCoordinatorDelegate {
    func didLogin() {
        self.mainScreenCoordinator = MainScreenCoordinator(presenter: presenter)
        self.mainScreenCoordinator?.start()
    }
    
    func didCreateNewUser() {
        self.profileCoordinator = ProfileCoordinator(presenter: presenter)
        self.profileCoordinator?.start()
    }
}
