//
//  ChatViewModelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ChatViewModelTests: QuickSpec {
    override func spec() {
        var subject: ChatViewModel!
        
        describe("ChatViewModel") {
            beforeEach {
                subject = ChatViewModel(user: Fixtures.mockUser,
                                        channel: Channel(document: MockDocument(type: .channel))!)
            }
            
            it("subject is available") {
                expect(subject).toNot(beNil())
            }
            
            it("calls delegate when message is added") {
                subject.handleDocumentChange(MockDocumentChange(changeType: .added,
                                                                documentType: .message))
                expect(subject.messages.isEmpty).to(beFalse())
            }
            
            it("gets images when image message is added") {
                let bundle = Bundle(for: type(of: self))
                guard
                    let url = bundle.path(forResource: "octocat", ofType: "png")
                else { fail("Please provide image url"); return }
                
                subject.handleDocumentChange(MockDocumentChange(changeType: .added,
                                                                documentType: .image(url: url)))
                expect(subject.messages.isEmpty).to(beFalse())
            }
            
            it("uploads image") {
                subject.sendPhoto(Fixtures.mockImage)
                
                fail("Assertions pending")
            }
            
            
        }
    
        describe("ChatViewModel with invalid Channel") {
            beforeEach {
                subject = ChatViewModel(user: Fixtures.mockUser, channel: Fixtures.mockChannelwithoutID)
            }
            
            it("subject is nil") {
                expect(subject).to(beNil())
            }
        }
    }
}
