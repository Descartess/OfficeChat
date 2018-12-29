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
    static let testEnvironment = AppEnvironment(authManager: MockAuthManager())
    static let mockUser = MockUser(displayName: "testUser")
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
