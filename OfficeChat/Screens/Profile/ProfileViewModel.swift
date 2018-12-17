//
//  ProfileViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

class ProfileViewModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var isSaveEnabled: Bool = false
    
    func updateProfile(displayName: String, photoURL: URL? = nil, completion: @escaping () -> Void) {
        let userChangeRequest = user.createProfileChangeRequest()
        userChangeRequest.displayName = displayName
        userChangeRequest.photoURL = photoURL
        userChangeRequest.commitChanges { _ in
            completion()
        }
    }
}
