//
//  MainScreenCoordinator.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit

protocol MainScreenCoordinatorDelegate:class {
    func userDidSignOut()
}

class MainScreenCoordinator: Coordinator {
    let presenter: UIWindow
    var mainTabBarController: MainTabBarController?
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    func start() {
        guard
            let mainTabBarController = MainTabBarController.instantiate(from: .main)
        else { return }
        
        mainTabBarController.mainScreenCoordinatorDelegate = self
        self.mainTabBarController = mainTabBarController
        self.mainTabBarController?.setUpViewControllers()
        presenter.rootViewController = mainTabBarController
        presenter.makeKeyAndVisible()
    }
}

extension MainScreenCoordinator: MainScreenCoordinatorDelegate {
    func userDidSignOut() {
        let authenticationCoordinator = AuthenticationCoordinator(presenter: self.presenter)
        authenticationCoordinator.start()
    }
}
