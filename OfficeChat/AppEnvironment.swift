//
//  AppEnvironment.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct AppEnvironment {
    private static var environmentStack: [AppEnvironment] = [AppEnvironment(authManager: Auth.auth(),
                                                                            databaseManager: Firestore.firestore())
                                                            ]
    
    static var current: AppEnvironment {
        return environmentStack.last!
    }
    
    static func pushEnvironment(env: AppEnvironment) {
        environmentStack.append(env)
    }

    let authManager: AuthManagerProtocol
    let databaseManager: DatabaseManagerProtocol
}
