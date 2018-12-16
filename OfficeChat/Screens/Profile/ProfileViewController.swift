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
    }
    
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
