//
//  MockDatabaseManager.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 06/01/2019.
//  Copyright © 2019 Paul Nyondo. All rights reserved.
//

import Foundation
@testable import OfficeChat

class MockDatabaseManager: DatabaseManagerProtocol {
    func collectionReference(_ collectionPath: String) -> CollectionReferenceProtocol {
        return MockCollectionReference()
    }
}
