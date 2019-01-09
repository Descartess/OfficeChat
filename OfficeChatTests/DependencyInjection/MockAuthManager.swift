//
//  MockAuthManager.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

@testable import OfficeChat

class MockAuthManager: AuthManagerProtocol {
    var activeUser: UserProtocol?
    
    var signIn_wasCalled_withArgs: (String, String)?
    var createUser_wasCalled_withArgs: (String, String)?
    var signOut_wasCalled = false
    
    func signIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        signIn_wasCalled_withArgs = (email, password)
        activeUser = Fixtures.mockUser
        
        if let closure = completion {
            closure(nil, AlertReasons.custom)
        }
    }
    
    func createUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        createUser_wasCalled_withArgs = (email, password)
        activeUser = Fixtures.mockUser
        
        if let closure = completion {
            closure(nil, AlertReasons.custom)
        }
    }
    
    func signOut() throws {
        signOut_wasCalled = true
        activeUser = nil
    }
}
