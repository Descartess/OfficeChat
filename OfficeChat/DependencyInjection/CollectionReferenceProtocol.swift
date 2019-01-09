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
    func documentRef(_ documentPath: String) -> DocumentReferenceProtocol
    func addDocumentRef(data: [String : Any], completion: ((Error?) -> Void)?) -> DocumentReferenceProtocol
    func addSnapshotListener(_ listener: @escaping FIRQuerySnapshotBlock) -> ListenerRegistration
}

extension CollectionReference: CollectionReferenceProtocol {
    @discardableResult
    func addDocumentRef(data: [String : Any], completion: ((Error?) -> Void)?) -> DocumentReferenceProtocol {
        return self.addDocument(data: data, completion: completion)
    }
    
    func documentRef(_ documentPath: String) -> DocumentReferenceProtocol {
        return self.document(documentPath)
    }
}
