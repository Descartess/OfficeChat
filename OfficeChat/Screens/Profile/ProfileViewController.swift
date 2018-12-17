//
//  ProfileViewController.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioTextField: UITextField!
    @IBAction func saveProfile(_ sender: UIButton) {
        guard
            let vm = viewModel,
            let displayName = displayNameTextField.text,
            !displayName.isEmpty
        else { return }
        vm.updateProfile(displayName: displayName) {
            self.delegate?.didCreateUserProfile()
        }
    }
    
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: ProfileCoordinatorDelegate?
    
    var viewModel: ProfileViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        guard
            isViewLoaded,
            let vm = viewModel
        else { return }
        saveButton.isEnabled = vm.isSaveEnabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNameTextField.delegate = self
        displayNameTextField.addTarget(self,
                                       action: #selector(self.textFieldDidChange(_:)),
                                       for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ field: UITextField) {
        saveButton.isEnabled = field.hasText
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
