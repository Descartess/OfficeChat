//
//  AuthenticationCoordinator.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
class AuthenticationCoordinator : Coordinator {
    var loginViewController: LoginViewController?
    let presenter: UIWindow
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    func start() {
        guard
            let loginViewController = LoginViewController.instantiate(from: .main)
        else  { return }
        
        loginViewController.viewModel = LoginViewModel()
        presenter.rootViewController = loginViewController
        presenter.makeKeyAndVisible()
    }
}
