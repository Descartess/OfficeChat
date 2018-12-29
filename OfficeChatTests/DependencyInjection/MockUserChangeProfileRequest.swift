//
//  MockUserChangeProfileRequest.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 28/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

@testable import OfficeChat

class MockUserChangeProfileRequest: UserProfileChangeRequestProtocol {
    var commitChanges_wasCalled = false
    
    var displayName: String?
    
    var photoURL: URL?
    
    func commitChanges(completion: UserProfileChangeCallback? = nil) {
        commitChanges_wasCalled = true
    }
}
