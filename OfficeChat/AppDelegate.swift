//
//  AppDelegate.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 05/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Firebase
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        showStartUpScreen()
        return true
    }
    
    func showStartUpScreen() {
        guard
            let loginViewController = LoginViewController.instantiate(from: .main)
        else  { return }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        loginViewController.viewModel = LoginViewModel()
        self.window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
    }
}
