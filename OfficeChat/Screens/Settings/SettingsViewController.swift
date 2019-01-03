//
//  SettingsViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var displayName: UILabel!
    
    var viewModel: SettingsViewModel? {
        didSet {
            bindViewModel()
        }
    }
    weak var delegate: MainScreenCoordinatorDelegate?

    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
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
        signOut.layer.cornerRadius = 15
        deleteButton.layer.cornerRadius = 15
    }
    
    func bindViewModel() {
        guard
            isViewLoaded,
            let vm = viewModel
            else { return }
        displayName.text = vm.user.displayName
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func userDidSignOut() {
        delegate?.userDidSignOut()
    }
}
