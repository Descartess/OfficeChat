//
//  ChatListViewModelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import OfficeChat

class ChatListViewModelTests:QuickSpec {
    override func spec() {
        var subject: ChatListViewModel!
        var delegate: MockChatListDelegate!
        
        describe("ChatList View Model") {
            beforeEach {
                subject = ChatListViewModel(currentUser: Fixtures.mockUser)
                delegate = MockChatListDelegate()
                subject.delegate = delegate
            }
            
            it("delegate was called channel is added") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .added, documentType: .channel))
                expect(delegate.channel_wasAdded).to(beTrue())
            }
            
            it("delegate was called channel is modified") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .modified, documentType: .channel))
                expect(delegate.channel_wasModified).to(beTrue())
            }
            
            it("delegate was called channel is removed") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .removed, documentType: .channel))
                expect(delegate.channel_wasRemoved).to(beTrue())
            }
            
            it("searches channels") {
                subject.search(text: "No channel")
                expect(subject.channels.isEmpty).to(beTrue())
            }
        }
    }
}

class MockChatListDelegate: ChatListDelegate {
    var channel_wasAdded = false
    var channel_wasModified = false
    var channel_wasRemoved = false
    
    func added(channel: Channel) {
        channel_wasAdded = true
    }
    func modified(channel: Channel) {
        channel_wasModified = true
    }
    func removed(channel: Channel) {
        channel_wasRemoved = true
    }
}

