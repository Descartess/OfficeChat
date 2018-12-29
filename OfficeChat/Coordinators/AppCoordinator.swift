//
//  AppCoordinator.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

class AppCoordinator: Coordinator {
    let window: UIWindow
    var mainTabBarCoordinator: MainScreenCoordinator?
    var authenticationCoordinator: AuthenticationCoordinator?
    
    var authManager: AuthManagerProtocol {
       return  AppEnvironment.current.authManager
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if authManager.activeUser != nil {
            self.mainTabBarCoordinator = MainScreenCoordinator(presenter: window)
            mainTabBarCoordinator?.start()
        } else {
            self.authenticationCoordinator = AuthenticationCoordinator(presenter: window)
            authenticationCoordinator?.start()
        }
    }
}
