//
//  DatabaseManagerProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

protocol DatabaseManagerProtocol {
    func collection(_ collectionPath: String) -> CollectionReference
}

extension Firestore: DatabaseManagerProtocol {
    
}
