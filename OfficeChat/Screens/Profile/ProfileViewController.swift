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
    
    func setUpViews() {
        displayNameTextField.layer.cornerRadius = 32
        displayNameTextField.layer.shadowColor = UIColor.black.cgColor
        displayNameTextField.layer.shadowOpacity = 0.2
        displayNameTextField.layer.shadowOffset = CGSize.zero
        displayNameTextField.layer.shadowRadius = 10
        
        bioTextField.layer.cornerRadius = 32
        bioTextField.layer.shadowColor = UIColor.black.cgColor
        bioTextField.layer.shadowOpacity = 0.2
        bioTextField.layer.shadowOffset = CGSize.zero
        bioTextField.layer.shadowRadius = 10
        
        saveButton.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
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
