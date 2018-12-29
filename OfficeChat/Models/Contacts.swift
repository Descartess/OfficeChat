//
//  Contacts.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 23/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

struct Contact {
    var user_id: String
    var name: String
    var photoUrl: URL?
    var bio: String?
    
    init(id: String, name:String, photoUrl: URL?  = nil, bio: String? = nil) {
        self.user_id = id
        self.name = name
        self.bio = bio
        self.photoUrl = photoUrl
    }
    init?(document: DocumentProtocol) {
       let data = document.data()
        guard
            let user_id = data["user_id"] as? String,
            let name = data["name"] as? String
        else { return nil}
        
        self.user_id = user_id
        self.name = name
        
        if let url = data["photoUrl"] as? URL {
            self.photoUrl = url
        }
        
        if let bio = data["bio"] as? String {
            self.bio = bio
        }
    }
}

extension Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Contact: JSONRepresentation {
    var representation: [String : Any] {
        var rep: [String: Any] = ["name": name, "user_id": user_id]
        if let url = photoUrl {
            rep["photoUrl"] = url
        }
        if let bio = bio {
            rep["bio"] = bio
        }
        return rep
    }
}
