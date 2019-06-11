//
//  ChannelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ChannelTests: QuickSpec {
    override func spec() {
        var subject: Channel!
        describe("Channel tests") {
            beforeEach {
                subject = Channel(document: Fixtures.mockChannel)
            }
            
            it(" has representation"){
                expect(subject.representation).toNot(beNil())
            }
        }
    }
}
