//
//  SettingsViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SettingsViewModel {
    let user: UserProtocol
    
    init(user: UserProtocol) {
        self.user = user
    }
    var authManager: AuthManagerProtocol {
        return AppEnvironment.current.authManager
    }
    
    let db = Firestore.firestore()
    
    var contactReference: CollectionReference {
        return db.collection("contacts")
    }
    
    weak var delegate: SettingsViewModelDelegate?
    
    func signOut() {
        do {
            try authManager.signOut()
            delegate?.userDidSignOut()
        } catch let error {
            print(error)
        }
    }
    
    func deleteAccount() {
        contactReference.document(user.uid).delete()

        user.delete { _ in
            self.delegate?.userDidSignOut()
        }
    }
}
