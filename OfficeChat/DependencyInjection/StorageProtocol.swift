//
//  StorageProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 07/01/2019.
//  Copyright © 2019 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseStorage

protocol StorageProtocol {
    func referenceProtocol() -> StorageReferenceProtocol
}

extension Storage: StorageProtocol {
    func referenceProtocol() -> StorageReferenceProtocol {
        return self.reference()
    }
}
