//
//  ChatViewDelegate.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation

protocol ChatViewDelegate: class {
    func insertNewMessage(_ message: Message)
    func didSaveMessage()
    func isUploadingPhoto()
}
