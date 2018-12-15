//
//  ChatListViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 09/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ChatListViewModel {
    let db = Firestore.firestore()
    var chatReference: CollectionReference {
        return db.collection("channels")
    }
    weak var delegate: ChatListDelegate?
    
    var channels = [Channel]()
    
    var currentUser: User
    
    var channelListener: ListenerRegistration?
    
    deinit {
        channelListener?.remove()
    }
    
    init(currentUser: User) {
        self.currentUser = currentUser
        channelListener = chatReference.addSnapshotListener { querySnapshot, _ in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }
    
    func handleDocumentChange(_ change: DocumentChange) {
        guard let channel = Channel(document: change.document) else { return }
        switch change.type {
        case .added:
            guard !channels.contains(channel) else { return }
            channels.append(channel)
            channels.sort()
            delegate?.added(channel: channel)
        case .modified:
            delegate?.modified(channel: channel)
        case .removed:
            delegate?.removed(channel: channel)
        }
    }
}
