//
//  MockCollectionReference.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 06/01/2019.
//  Copyright © 2019 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase
@testable import OfficeChat

class MockCollectionReference:CollectionReferenceProtocol {
    func documentRef(_ documentPath: String) -> DocumentReferenceProtocol {
        return MockDocumentReference()
    }
    
    func addDocumentRef(data: [String : Any], completion: ((Error?) -> Void)?) -> DocumentReferenceProtocol {
        if let closure = completion {
            closure(AlertReasons.custom)
        }
        return MockDocumentReference()
    }
    
    func addSnapshotListener(_ listener: @escaping FIRQuerySnapshotBlock) -> ListenerRegistration {
        return MockListenerRegistration()
    }
}

class MockDocumentReference: DocumentReferenceProtocol {
    
}

class MockListenerRegistration: NSObject {
    
}

extension MockListenerRegistration: ListenerRegistration {
    func remove() {
        
    }
}




