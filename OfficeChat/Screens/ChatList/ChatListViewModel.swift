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
    
    var filterText = ""
    
    var allChannels = [Channel]()
    
    var channels: [Channel] {
        if filterText.isEmpty {
            return self.allChannels
        } else {
            return self.allChannels.filter { $0.name.contains(filterText) }
        }
    }

    var currentUser: UserProtocol
    
    var channelListener: ListenerRegistration?
    
    deinit {
        channelListener?.remove()
    }
    
    func search(text: String) {
        filterText = text
    }
    
    init(currentUser: UserProtocol) {
        self.currentUser = currentUser
        channelListener = chatReference.addSnapshotListener { querySnapshot, _ in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    }
    
    func createChannel(_ channel: Channel) {
        chatReference.addDocument(data: channel.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }
    }
    
    func handleDocumentChange(_ change: DocumentChangeProtocol) {
        guard let channel = Channel(document: change.data) else { return }
        switch change.type {
        case .added:
            guard !allChannels.contains(channel) else { return }
            allChannels.append(channel)
            allChannels.sort()
            delegate?.added(channel: channel)
        case .modified:
            delegate?.modified(channel: channel)
        case .removed:
            delegate?.removed(channel: channel)
        }
    }
}
