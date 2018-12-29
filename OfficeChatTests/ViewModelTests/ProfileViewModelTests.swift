//
//  ProfileViewModelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ProfileViewModelTests: QuickSpec {
    override func spec() {
        var subject: ProfileViewModel!
        
        describe("Profile View Model") {
            beforeEach {
                subject =  ProfileViewModel(user: Fixtures.mockUser)
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
            }
            
            it("commits chnages to user profile") {
                subject.updateProfile(displayName: "Paul Nyondo") {
                    
                }
                expect(Fixtures.mockChangeProfileRequest.commitChanges_wasCalled).to(beTrue())
            }
        }
    }
}
