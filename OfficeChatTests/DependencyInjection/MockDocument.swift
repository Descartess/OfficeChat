//
//  MockDocument.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 28/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
@testable import OfficeChat

enum DocumentType {
    case message
    case contact
    case channel
    case image(url: String)
}

class MockDocument: DocumentProtocol {
    
    var documentID: String {
        return "documentID_123"
    }
    
    var type: DocumentType
    
    func data() -> [String : Any] {
        switch type {
        case .channel:
            return ["name":"testChannel"]
        case .contact:
            return ["name": "Paul",
                    "bio": "A beautiful mind ... ",
                    "user_id":"uid_123",
                    "photoUrl": "http://www.example.com"
            ]
        case .message:
            return ["created": Date(),
                    "content": "Test Message",
                    "senderID": "uid_123",
                    "senderName": "Paul",
            ]
        case .image(let url):
            return ["created": Date(),
                    "senderID": "uid_123",
                    "senderName": "Paul",
                    "url": url
            ]
        }
    }
    
    init(type: DocumentType) {
        self.type = type
    }
    
    
}
