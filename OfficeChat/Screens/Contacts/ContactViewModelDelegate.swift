//
//  ContactViewModelDelegate.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 23/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation

protocol ContactViewModelDelegate: class {
    func added(channel: Contact)
    func modified(channel: Contact)
    func removed(channel: Contact)
}
