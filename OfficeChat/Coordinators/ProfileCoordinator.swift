//
//  ProfileCoordinator.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 16/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol ProfileCoordinatorDelegate: class {
    func didCreateUserProfile()
}

class ProfileCoordinator: Coordinator {
    let presenter: UIWindow
    var mainScreenCoordinator: MainScreenCoordinator?
    var profileViewController: ProfileViewController?
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    func start() {
        let authManager = AppEnvironment.current.authManager
        guard
            let profileViewController = ProfileViewController.instantiate(from: .main),
            let user = authManager.activeUser
        else { return }
        
        self.profileViewController = profileViewController
        self.profileViewController?.delegate = self
        let profileViewModel = ProfileViewModel(user: user)
        self.profileViewController?.viewModel = profileViewModel
        presenter.rootViewController = profileViewController
        presenter.makeKeyAndVisible()
    }
}

extension ProfileCoordinator: ProfileCoordinatorDelegate {
    func didCreateUserProfile() {
        self.mainScreenCoordinator = MainScreenCoordinator(presenter: presenter)
        self.mainScreenCoordinator?.start()
    }
}
