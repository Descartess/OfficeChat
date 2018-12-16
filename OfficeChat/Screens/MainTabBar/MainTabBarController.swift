//
//  MainTabBarController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    var indexOfSelectedVC = 0
    
    weak var mainScreenCoordinatorDelegate: MainScreenCoordinatorDelegate?
    
    func setUpViewControllers() {
        let settingsViewController = SettingsViewController.instantiate(from: .main)
        let chatListViewController = ChatListViewController.instantiate(from: .main)
        
        guard
            let settingsVC = settingsViewController,
            let chatListVC = chatListViewController,
            let user = Auth.auth().currentUser
        else { return }
        
        let chatListViewModel = ChatListViewModel(currentUser: user)
        chatListViewModel.delegate = chatListVC
        chatListVC.viewModel = chatListViewModel
        
        let settingsViewModel = SettingsViewModel(user: user)
        settingsViewModel.delegate = settingsVC
        settingsVC.delegate = mainScreenCoordinatorDelegate
        settingsVC.viewModel = settingsViewModel
        
        let chatListNavigationController = UINavigationController(rootViewController: chatListVC)

        chatListNavigationController.tabBarItem = UITabBarItem(title: "Chats", image: nil, tag: 0)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 1)
        
        self.viewControllers = [chatListNavigationController, settingsVC]
        self.selectedIndex = indexOfSelectedVC
    }
}
