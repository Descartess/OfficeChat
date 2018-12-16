//
//  SettingsViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

class SettingsViewModel {
    let user: User
    init(user: User) {
        self.user = user
    }
    weak var delegate: SettingsViewModelDelegate?
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error)
        }
    }
    
    func deleteAccount() {
        user.delete(completion: nil)
    }
}
