//
//  AuthManagerProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

protocol AuthManagerProtocol {
    var  activeUser: UserProtocol? { get }
    func signIn(withEmail email: String, password: String, completion: AuthDataResultCallback?)
    func createUser(withEmail email: String, password: String, completion: AuthDataResultCallback?)
    func signOut() throws
}

extension Auth: AuthManagerProtocol {
    var activeUser: UserProtocol? {
        return self.currentUser
    }
}
