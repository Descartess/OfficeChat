//
//  ProfileCoordinator.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 16/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    let presenter: UIWindow
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    func start() {
        guard let profileViewController = ProfileViewController.instantiate(from: .main) else { return }
        let profileViewModel = ProfileViewModel()
        profileViewController.viewModel = profileViewModel
        presenter.rootViewController = profileViewController
        presenter.makeKeyAndVisible()
    }
}
