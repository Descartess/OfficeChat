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
    
    var applicationCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        self.applicationCoordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        
        applicationCoordinator?.start()
        return true
    }
}
