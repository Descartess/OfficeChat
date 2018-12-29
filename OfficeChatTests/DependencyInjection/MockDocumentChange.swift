//
//  MockDocumentChange.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 28/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase
@testable import OfficeChat

class MockDocumentChange: DocumentChangeProtocol {
    var type: DocumentChangeType
    var data: DocumentProtocol {
        get {
            return MockDocument(type: self.documentType)
        }
    }
    var documentType: DocumentType
    
    init(changeType: DocumentChangeType, documentType: DocumentType) {
        self.type = changeType
        self.documentType = documentType
    }
}
