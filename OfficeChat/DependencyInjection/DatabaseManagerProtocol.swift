//
//  DatabaseManagerProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol DatabaseManagerProtocol {
    func collectionReference(_ collectionPath: String) -> CollectionReferenceProtocol
}

extension Firestore: DatabaseManagerProtocol {
    func collectionReference(_ collectionPath: String) -> CollectionReferenceProtocol {
        return self.collection(collectionPath)
    }
}
