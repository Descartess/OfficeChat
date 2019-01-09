//
//  ContactsViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
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
                subject.loadViewIfNeeded()
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
                expect(subject.tableView).toNot(beNil())
            }
            
            it("table view is empty"){
                let tableView = subject.tableView!
                tableView.reloadData()
                expect(tableView.numberOfRows(inSection: 0)).to(equal(0))
            }
            it("shows and hides search bar on toggle") {
                subject.searchButtonPressed()
                expect(subject.showSearchBar).to(beTrue())
                expect(subject.navigationItem.titleView).toNot(beNil())
                
                subject.cancelButtonPressed()
                expect(subject.showSearchBar).to(beFalse())
                expect(subject.navigationItem.titleView).to(beNil())
            }
        }
        
        describe("Contacts View Controller with contacts") {
            beforeEach {
                guard
                    let contactsViewController = ContactsViewController.instantiate(from: .main)
                    else { fail("contactsViewController must not be nil"); return }
                
                viewModel = ContactsViewModel(currentUser: Fixtures.mockUser)
                viewModel.allContacts = Fixtures.contacts
                subject = contactsViewController
                subject.loadViewIfNeeded()
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
                expect(subject.tableView).toNot(beNil())
            }
            
            it("table view has contacts"){
                let tableView = subject.tableView!
                tableView.reloadData()
                expect(tableView.numberOfRows(inSection: 0)).to(equal(Fixtures.contacts.count))
            }
            
            it("updates table view on search") {
                let tableView = subject.tableView!
                subject.searchBar(UISearchBar(), textDidChange: "No Contact")
                expect(tableView.numberOfRows(inSection: 0)).to(equal(0))
            }
            
            it("updates table view on removal of contact") {
                let tableView = subject.tableView!
                subject.viewModel!.allContacts.remove(at: 0)
                subject.removed(contact: Contact(document: Fixtures.mockContact)!)
                expect(tableView.numberOfRows(inSection: 0)).to(equal(Fixtures.contacts.count-1))
            }
            
            it("updates table view on addition of contact") {
                let tableView = subject.tableView!
                subject.added(contact: Contact(document: Fixtures.mockContact)!)
        
            }
            
            it("updates table view on modification of contact") {
                let tableView = subject.tableView!
                subject.modified(contact: Contact(document: Fixtures.mockContact)!)
                expect(tableView.numberOfRows(inSection: 0)).to(equal(Fixtures.contacts.count))
            }
            
            it("has correct cell text"){
                let tableView = subject.tableView!
                let cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell.textLabel?.text).to(equal("Paul"))
            }
        }
    }
}
