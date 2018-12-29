//
//  UserProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

protocol UserProtocol {
    var uid: String { get }
    var displayName: String? { get }
    var providerID: String { get }
    var email: String? { get }
    func delete(completion: UserProfileChangeCallback?)
    func startProfileChangeRequest() -> UserProfileChangeRequestProtocol
}

protocol UserProfileChangeRequestProtocol {
    var displayName: String? { get set }
    var photoURL: URL? { get set }
    func commitChanges(completion: UserProfileChangeCallback?)
}

extension User: UserProtocol {
    func startProfileChangeRequest() -> UserProfileChangeRequestProtocol {
        return self.createProfileChangeRequest()
    }
}

extension UserProfileChangeRequest: UserProfileChangeRequestProtocol {
    
}
