//
//  Fixtures.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
@testable import OfficeChat

class Fixtures {
    static let testEnvironment = AppEnvironment(authManager: MockAuthManager(),
                                                databaseManager: MockDatabaseManager())
    
    static let userEmail = "paul@test.com"
    static let userPassword = "password123"
    
    static let mockImage: UIImage = {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
        
        let image = renderer.image { context in
            UIColor.darkGray.setStroke()
            context.stroke(renderer.format.bounds)
        }
        return image
    }()
    
    static let mockUser = MockUser(displayName: "testUser")
    static let mockUser2 = MockUser(displayName: "testUser2", id: "user_2")
    
    static let mockContact = MockDocument(type: .contact, id: "contact_1")
    static let mockContact2 = MockDocument(type: .contact, id: "contact_2")
    
    static let mockChannel = MockDocument(type: .channel, id: "channel_1")
    static let mockChannel2 = MockDocument(type: .channel, id: "channel_2")
    
    static let mockMessages = MockDocument(type: .message, id: "msg_1", user: mockUser)
    static let mockMessages2 = MockDocument(type: .message, id: "msg_2", user: mockUser2)

    static let messages: [Message] = [Message(document: mockMessages)!,Message(document: mockMessages2)!]
    static let channels: [Channel] = [Channel(document: mockChannel)!, Channel(document: mockChannel2)!]
    static let contacts: [Contact] = [Contact(document: mockContact)!, Contact(document: mockContact2)!]
    
    static let mockChangeProfileRequest = MockUserChangeProfileRequest()
    
    static let mockChannelwithoutID = Channel(name: "testChannel")
    
    class func createUser() {
        guard
            let authManager = AppEnvironment.current.authManager as? MockAuthManager
        else { return }
        
        authManager.createUser(withEmail: userEmail,
                               password: userPassword,
                               completion: nil)
    }
}
