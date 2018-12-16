//
//  SettingsViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModel?
    
    weak var delegate: MainScreenCoordinatorDelegate?

    @IBAction func signOutAction(_ sender: UIButton) {
        guard
            let vm = viewModel
        else { return }
        vm.signOut()
    }
    
    @IBAction func deleteAccountAction(_ sender: UIButton) {
        guard
            let vm = viewModel
        else { return }
        vm.deleteAccount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func userDidSignOut() {
        
    }
}
