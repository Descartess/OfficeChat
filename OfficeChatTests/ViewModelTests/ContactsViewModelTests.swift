//
//  ContactListViewModelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ContactsViewModelTests:QuickSpec {
    override func spec() {
        var subject: ContactsViewModel!
        var delegate: MockContactViewModelDelegate!
        
        describe("ChatList View Model") {
            beforeEach {
                subject = ContactsViewModel(currentUser: Fixtures.mockUser)
                delegate = MockContactViewModelDelegate()
                subject.delegate = delegate
            }
            
            it("delegate was called contact is added") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .added, documentType: .contact))
                expect(delegate.contact_wasAdded).to(beTrue())
            }
            
            it("delegate was called contact is modified") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .modified, documentType: .contact))
                expect(delegate.contact_wasModified).to(beTrue())
            }
            
            it("delegate was called contact is removed") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .removed, documentType: .contact))
                expect(delegate.contact_wasRemoved).to(beTrue())
            }
            
            it("searches contact") {
                subject.search(text: "No contacts")
                expect(subject.contacts.isEmpty).to(beTrue())
            }
        }
    }
}

class MockContactViewModelDelegate: ContactViewModelDelegate {
    var contact_wasAdded = false
    var contact_wasModified = false
    var contact_wasRemoved = false
    
    func added(channel: Contact) {
        contact_wasAdded = true
    }
    func modified(channel: Contact) {
        contact_wasModified = true
    }
    func removed(channel: Contact) {
        contact_wasRemoved = true
    }
}
