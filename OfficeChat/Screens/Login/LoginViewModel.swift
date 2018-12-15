//
//  File.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 09/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var email: String?
    var password: String?
    init() {
        self.email = ""
        self.password = ""
    }
    
    func checkValidEmail(_ email: String) -> Bool {
        guard
            !email.isEmpty,
            !email.contains(" "),
            !(email.last == "."),
            email.count > 5,
            email.contains("@") && email.contains(".")
        else
            { return false }
        return true
    }
    
    func checkPasswordLength(_ password: String) -> Bool {
        guard
            password.count > 4
            else { return false }
        return true
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error != nil, user == nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, _ in
            if user != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
