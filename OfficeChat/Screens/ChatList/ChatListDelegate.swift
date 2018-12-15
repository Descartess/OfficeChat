//
//  ChatListDelegate.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 11/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation

protocol ChatListDelegate: class {
    func added(channel: Channel)
    func modified(channel: Channel)
    func removed(channel: Channel)
}
