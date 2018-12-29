//
//  ChatViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ChatViewControllerTests: QuickSpec {
    override func spec() {
        var subject: ChatViewController!
        var viewModel: ChatViewModel!
        
        describe("ChatViewController") {
            beforeEach {
                viewModel = ChatViewModel(user: Fixtures.mockUser,
                                          channel: Channel(document: MockDocument(type: .channel))!)
                subject = ChatViewController()
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
        }
    }
}
