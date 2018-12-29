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
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
        }
    }
}
