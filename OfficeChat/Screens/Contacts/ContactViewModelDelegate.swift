//
//  ContactViewModelDelegate.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 23/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation

protocol ContactViewModelDelegate: class {
    func added(contact: Contact)
    func modified(contact: Contact)
    func removed(contact: Contact)
}
