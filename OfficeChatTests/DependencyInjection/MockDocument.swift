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
        return _id
    }
    var _id: String
    var type: DocumentType
    var user_id: String
    
    func data() -> [String : Any] {
        switch type {
        case .channel:
            return ["name":"testChannel"]
        case .contact:
            return ["name": "Paul",
                    "bio": "A beautiful mind ... ",
                    "user_id": user_id,
                    "photoUrl": "http://www.example.com"
            ]
        case .message:
            return ["created": Date(),
                    "content": "Test Message",
                    "senderID": user_id,
                    "senderName": "Paul",
            ]
        case .image(let url):
            return ["created": Date(),
                    "senderID": user_id,
                    "senderName": "Paul",
                    "url": url
            ]
        }
    }
    
    init(type: DocumentType, id: String = "documentID_123", user: UserProtocol = Fixtures.mockUser) {
        self.type = type
        self._id = id
        self.user_id = user.uid
    }
    
    
}
