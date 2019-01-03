//
//  AppEnvironment.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

struct AppEnvironment {
    private static var environmentStack: [AppEnvironment] = [AppEnvironment(authManager: Auth.auth())]
    
    static var current: AppEnvironment {
        return environmentStack.last!
    }
    
    static func pushEnvironment(env: AppEnvironment) {
        environmentStack.append(env)
    }

    let authManager: AuthManagerProtocol
}
