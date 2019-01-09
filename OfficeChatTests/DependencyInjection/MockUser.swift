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
    
    var uid: String {
        return _id
    }
    
    var providerID = "email"
    
    var email: String?
    
    var delete_wasCalled = false
    
    var _id: String
    
    init(displayName: String, id: String = "uid_124") {
        self.displayName = displayName
        self._id = id
    }
    
    func delete(completion: UserProfileChangeCallback? = nil) {
        delete_wasCalled = true
        
        if let closure = completion {
            closure(nil)
        }
    }
    
    func startProfileChangeRequest() -> UserProfileChangeRequestProtocol {
         return Fixtures.mockChangeProfileRequest
    }
}
