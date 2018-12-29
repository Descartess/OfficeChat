//
//  DocumentProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 28/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Firebase

protocol DocumentProtocol {
    var documentID: String { get }
    func data() -> [String : Any]
}

extension QueryDocumentSnapshot: DocumentProtocol {
    
}
