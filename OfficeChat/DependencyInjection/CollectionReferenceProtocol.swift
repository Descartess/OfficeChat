//
//  CollectionReferenceProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

protocol  CollectionReferenceProtocol {
    func document(_ documentPath: String) -> DocumentReference
    func addDocument(data: [String : Any], completion: ((Error?) -> Void)?) -> DocumentReference
    func addSnapshotListener(_ listener: @escaping FIRQuerySnapshotBlock) -> ListenerRegistration
}

extension CollectionReference: CollectionReferenceProtocol {
    
}
