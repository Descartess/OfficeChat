//
//  ContactsViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 23/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactsViewModel {
    let db = Firestore.firestore()
    
    var contactReference: CollectionReference {
        return db.collection("contacts")
    }
    
    weak var delegate: ContactViewModelDelegate?
    
    var allContacts = [Contact]()
    
    var filterText = ""
    
    var contacts: [Contact] {
        if filterText.isEmpty {
            return self.allContacts
        } else {
            return self.allContacts.filter { $0.name.contains(filterText) }
        }
    }
    
    var currentUser: UserProtocol
    
    var contactListener: ListenerRegistration?
    
    deinit {
        contactListener?.remove()
    }
    
    init(currentUser: UserProtocol) {
        self.currentUser = currentUser
        contactListener = contactReference.addSnapshotListener { querySnapshot, _ in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }
    
    func handleDocumentChange(_ change: DocumentChangeProtocol) {
        guard let contact = Contact(document: change.data) else { return }
        switch change.type {
        case .added:
            guard !allContacts.contains(contact) else { return }
            allContacts.append(contact)
            allContacts.sort()
            delegate?.added(channel: contact)
        case .modified:
            delegate?.modified(channel: contact)
        case .removed:
            delegate?.removed(channel: contact)
        }
    }
    
    func search(text: String) {
        filterText = text
    }
}
