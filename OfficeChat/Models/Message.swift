//
//  Message.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 12/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import MessageKit
import Firebase

struct Message: MessageType {
    var kind: MessageKind
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var sender: Sender
    var content: String
    var sentDate: Date
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    let id: String?
    
    init(user: User, content: String) {
        sender = Sender(id: user.uid, displayName: "")
        self.content = content
        id = nil
        sentDate = Date()
        kind = .text(content)
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard
            let sentDate = data["created"] as? Date,
            let senderID = data["senderID"] as? String,
            let senderName = data["senderName"] as? String
        else { return nil }
        
        
        id = document.documentID
        
        self.sentDate = sentDate
        sender = Sender(id: senderID, displayName: senderName)
        
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            content = ""
        } else {
            return nil
        }
        kind = .text(self.content)
    }
}

extension Message: Comparable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

extension Message: JSONRepresentation {
    var representation: [String : Any] {
        var rep: [String:Any] = [
            "created":sentDate,
            "senderID": sender.id,
            "senderName": sender.displayName
            ]
        
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        return rep
    }
}
