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
        let authManager = AppEnvironment.current.authManager
        
        let settingsViewController = SettingsViewController.instantiate(from: .main)
        let chatListViewController = ChatListViewController.instantiate(from: .main)
        let contactsViewController = ContactsViewController.instantiate(from: .main)
        
        guard
            let settingsVC = settingsViewController,
            let chatListVC = chatListViewController,
            let contactsVC = contactsViewController,
            let user = authManager.activeUser
        else { return }
        
        chatListVC.loadViewIfNeeded()
        settingsVC.loadViewIfNeeded()
        contactsVC.loadViewIfNeeded()
        
        let chatListViewModel = ChatListViewModel(currentUser: user)
        chatListViewModel.delegate = chatListVC
        chatListVC.viewModel = chatListViewModel
        
        let contactsViewModel = ContactsViewModel(currentUser: user)
        contactsVC.viewModel = contactsViewModel
        
        let settingsViewModel = SettingsViewModel(user: user)
        settingsViewModel.delegate = settingsVC
        settingsVC.delegate = mainScreenCoordinatorDelegate
        settingsVC.viewModel = settingsViewModel
        
        let chatListNavigationController = UINavigationController(rootViewController: chatListVC)
        
        let contactsNavigationController = UINavigationController(rootViewController: contactsVC)

        chatListNavigationController.tabBarItem = UITabBarItem(title: "Chats", image: #imageLiteral(resourceName: "chats"), tag: 0)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "settings"), tag: 1)
        contactsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        self.viewControllers = [chatListNavigationController, contactsNavigationController, settingsVC]
        self.selectedIndex = indexOfSelectedVC
    }
}
