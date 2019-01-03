//
//  ContactsViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ContactsViewControllerTests: QuickSpec {
    override func spec() {
        var subject: ContactsViewController!
        var viewModel: ContactsViewModel!
        
        describe("Contacts View Controller") {
            beforeEach {
                guard
                    let contactsViewController = ContactsViewController.instantiate(from: .main)
                else { fail("contactsViewController must not be nil"); return }
                
                viewModel = ContactsViewModel(currentUser: Fixtures.mockUser)
                
                subject = contactsViewController
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
                expect(subject.tableView).toNot(beNil())
            }
        }
    }
}
