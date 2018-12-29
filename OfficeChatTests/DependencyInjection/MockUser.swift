//
//  MockUser.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseAuth

@testable import OfficeChat

class MockUser: UserProtocol {
    var displayName: String?
    
    var uid = "uid_123"
    
    var providerID = "email"
    
    var email: String?
    var delete_wasCalled = false
    
    init(displayName: String) {
        self.displayName = displayName
    }
    
    func delete(completion: UserProfileChangeCallback? = nil) {
        delete_wasCalled = true
    }
    
    func startProfileChangeRequest() -> UserProfileChangeRequestProtocol {
         return Fixtures.mockChangeProfileRequest
    }
}
