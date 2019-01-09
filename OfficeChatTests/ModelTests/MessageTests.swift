//
//  MessageTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class MessageTesst: QuickSpec {
    override func spec() {
        var subject: Message!
        
        describe("Message Model") {
            beforeEach {
                subject = Message(user: Fixtures.mockUser, content: "Hello World")
            }
            it("initialized with user and text") {
                expect(subject.sender.id).to(equal(Fixtures.mockUser.uid))
                expect(subject.content).to(equal("Hello World"))
                expect(subject.id).to(beNil())
            }
        }
        
        describe("Message Model") {
            beforeEach {
                subject = Message(user: Fixtures.mockUser, image: Fixtures.mockImage)
            }
            it("initialized with user and image") {
                expect(subject.sender.id).to(equal(Fixtures.mockUser.uid))
                expect(subject.content.isEmpty).to(beTrue())
                expect(subject.id).to(beNil())
                expect(subject.image).to(equal(Fixtures.mockImage))
            }
        }
        
        describe("Message Model") {
            beforeEach {
                subject = Message(document: MockDocument(type: .message))
            }
            it("initialized with query snapshot document") {
                expect(subject.sender.id).to(equal(Fixtures.mockUser.uid))
                expect(subject.content.isEmpty).to(beFalse())
                expect(subject.id).toNot(beNil())
            }
            it("has accurate dictionary representation") {
                expect(subject.representation).toNot(beNil())
            }
            
            it("has message id ") {
                expect(subject.messageId).toNot(beNil())
            }
        }
    }
}
