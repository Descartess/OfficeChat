//
//  ChatListViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ChatListViewControllerTests: QuickSpec {
    override func spec() {
        var subject: ChatListViewController!
        var viewModel: ChatListViewModel!
        
        describe("ChatListViewController") {
            beforeEach {
                guard
                    let chatListViewController = ChatListViewController.instantiate(from: .main)
                    else { fail("ChatListViewController must not be nil"); return }
                
                viewModel = ChatListViewModel(currentUser: Fixtures.mockUser)
                
                subject = chatListViewController
                subject.loadViewIfNeeded()
                subject.viewModel = viewModel

                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
            
            it("table view is empty"){
                let tableView = subject.chatListTableView!
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
        
        describe("ChatListViewController with no chats") {
            beforeEach {
                guard
                    let chatListViewController = ChatListViewController.instantiate(from: .main)
                    else { fail("ChatListViewController must not be nil"); return }
                
                viewModel = ChatListViewModel(currentUser: Fixtures.mockUser)
                viewModel.allChannels = Fixtures.channels
                
                subject = chatListViewController
                subject.loadViewIfNeeded()
                subject.viewModel = viewModel

                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
                expect(subject.chatListTableView).toNot(beNil())
            }
            
            it("table view has channels") {
                let tableView = subject.chatListTableView!
                tableView.reloadData()
                expect(tableView.numberOfRows(inSection: 0)).to(equal(Fixtures.channels.count))
            }
            
            it("updates table view on search") {
                let tableView = subject.chatListTableView!
                subject.searchBar(UISearchBar(), textDidChange: "No Channel")
                expect(tableView.numberOfRows(inSection: 0)).to(equal(0))
            }
            
            it("updates table view on removal of channel") {
                let tableView = subject.chatListTableView!
                subject.viewModel!.allChannels.remove(at: 0)
                subject.removed(channel: Channel(document: Fixtures.mockChannel)!)
                expect(tableView.numberOfRows(inSection: 0)).to(equal(Fixtures.channels.count-1))
            }
            
            it("updates table view on addition of channel") {
                let tableView = subject.chatListTableView!
                subject.added(channel: Channel(document: Fixtures.mockChannel)!)
        
            }
            
            it("updates table view on modification of channel") {
                let tableView = subject.chatListTableView!
                subject.modified(channel: Channel(document: Fixtures.mockChannel)!)
                expect(tableView.numberOfRows(inSection: 0)).to(equal(Fixtures.channels.count))
            }
            
            it("has correct cell text") {
                let tableView = subject.chatListTableView!
                let cell = subject.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell.textLabel?.text).to(equal("testChannel"))
            }
            
            it("shows alert controller"){
                subject.addButtonPressed()
                expect(subject.currentAlertController).toNot(beNil())
            }
            
            it("adds Channel") {
                subject.addButtonPressed()
                subject.currentAlertController?.textFields?.first?.text = "Channel 1"
                subject.createChannel()
            }
        }
        
    }
}
