//
//  ProfileViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel {
    let user: UserProtocol
    
    let db = Firestore.firestore()
    
    var contactReference: CollectionReference {
        return db.collection("contacts")
    }
    
    init(user: UserProtocol) {
        self.user = user
    }
    
    var isSaveEnabled: Bool = false
    
    func updateProfile(displayName: String,
                       photoURL: URL? = nil,
                       bio: String? = nil,
                       completion: @escaping () -> Void) {
        
        let contact = Contact(id: user.uid,
                              name: displayName,
                              photoUrl: photoURL,
                              bio: bio)
        
        self.contactReference.document(user.uid).setData(contact.representation)
        
        var userChangeRequest = user.startProfileChangeRequest()
        
        userChangeRequest.displayName = displayName
        userChangeRequest.photoURL = photoURL
        userChangeRequest.commitChanges { _ in
            completion()
        }
    }
}
