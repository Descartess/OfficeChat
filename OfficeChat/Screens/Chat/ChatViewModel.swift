//
//  ChatViewModel.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ChatViewModel {
    
    let db = Firestore.firestore()
    var reference: CollectionReference?
    
    var messages = [Message]()
    var messageListener: ListenerRegistration?
    weak var delegate: ChatViewDelegate?
    
    var user: User
    var channel: Channel
    
    init?(user: User, channel: Channel) {
        self.user = user
        self.channel = channel
        guard let id = channel.id else {
            return nil
        }
        reference = db.collection(["channels", id, "thread"].joined(separator:"/"))
        
        messageListener = reference?.addSnapshotListener { querySnapshot, _ in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }
    
    func insertNewMessage(_ message: Message) {
        guard !messages.contains(message) else { return }
        messages.append(message)
        messages.sort()
        delegate?.insertNewMessage(message)
    }
    
    func save(_ message: Message) {
        reference?.addDocument(data: message.representation) { error in
            if error != nil {
                return
            }
        }
    }
    
    func handleDocumentChange(_ change: DocumentChange) {
        guard let message = Message(document: change.document) else { return }
        switch change.type {
        case .added:
            insertNewMessage(message)
        default:
            break
        }
    }
    
    deinit {
        messageListener?.remove()
    }
}
