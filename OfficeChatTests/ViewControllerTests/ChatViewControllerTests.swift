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
import UIKit
import MessageKit

@testable import OfficeChat

class ChatViewControllerTests: QuickSpec {
    override func spec() {
        var subject: ChatViewController!
        var viewModel: ChatViewModel!
        
        describe("ChatViewController no messages") {
            beforeEach {
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
                viewModel = ChatViewModel(user: Fixtures.mockUser,
                                          channel: Channel(document: MockDocument(type: .channel))!)
                subject = ChatViewController()
    
                subject.loadViewIfNeeded()
                subject.viewModel = viewModel
                
                
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
        }
        
        describe("ChatViewController with messages") {
            beforeEach {
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
                viewModel = ChatViewModel(user: Fixtures.mockUser,
                                          channel: Channel(document: MockDocument(type: .channel))!)
                
                viewModel.messages = Fixtures.messages
                
                subject = ChatViewController()
                subject.loadViewIfNeeded()
                subject.viewModel = viewModel
                subject.beginAppearanceTransition(true, animated: true)
                subject.endAppearanceTransition()
                subject.view.layoutIfNeeded()
                
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
            
            it("view has messages") {
                let collectionView = subject.messagesCollectionView
                collectionView.reloadData()
                expect(collectionView.numberOfSections).to(equal(Fixtures.messages.count))
            }
            
            it("has the proper cell") {
                let collectionView = subject.messagesCollectionView
                _ = collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? TextMessageCell
                
            }
            
            it("scrolls to bottom on save message") {
                subject.didSaveMessage()
            }
            
            it("disables input bar while uploading messages") {
                subject.isUploadingPhoto()
            }
            
            it("scrolls to bottom on insertion of message") {
                let message = Message(document: Fixtures.mockMessages2)!
                subject.insertNewMessage(message)
            }
        }
    }
}
