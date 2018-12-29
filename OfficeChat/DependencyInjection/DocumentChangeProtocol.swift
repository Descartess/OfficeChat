//
//  DocumentChangeProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 28/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

protocol DocumentChangeProtocol {
    var type: DocumentChangeType { get }
    var data: DocumentProtocol { get }
}

extension DocumentChange: DocumentChangeProtocol {
    var data: DocumentProtocol {
        return self.document
    }
}
