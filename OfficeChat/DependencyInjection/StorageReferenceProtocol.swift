//
//  StorageReferenceProtocol.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 07/01/2019.
//  Copyright © 2019 Paul Nyondo. All rights reserved.
//

import Foundation
import FirebaseStorage

protocol StorageReferenceProtocol {
    func childReference(_ path: String) -> StorageReferenceProtocol
    func putDataTask(_ uploadData: Data,
                     metadata: StorageMetadata?,
                     completion: ((StorageMetadata?, Error?) -> Void)?) -> StorageUploadTaskProtocol
    func downloadURL(completion: @escaping (URL?, Error?) -> Void)
}

extension StorageReference: StorageReferenceProtocol {
    func putDataTask(_ uploadData: Data,
                     metadata: StorageMetadata?,
                     completion: ((StorageMetadata?, Error?) -> Void)?) -> StorageUploadTaskProtocol {
        return self.putData(uploadData, metadata: metadata, completion: completion)
    }
    
    func childReference(_ path: String) -> StorageReferenceProtocol {
       return self.child(path)
    }
}

protocol StorageUploadTaskProtocol {
    func observe(_ status: StorageTaskStatus, handler: @escaping (StorageTaskSnapshot) -> Void) -> String
}

extension StorageUploadTask: StorageUploadTaskProtocol {
    
}
