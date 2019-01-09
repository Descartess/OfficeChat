//
//  SettingsViewModelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class SettingsViewModelTests: QuickSpec {
    override func spec() {
        var subject: SettingsViewModel!
        var delegate: MockSettingsViewModelDelegate!
        
        describe("Settings View Model") {
            beforeEach {
                subject =  SettingsViewModel(user: Fixtures.mockUser)
                delegate =  MockSettingsViewModelDelegate()
                subject.delegate = delegate
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
            }
            
            it("calls delegate on sign out") {
                subject.signOut()
                
                guard
                    let authManager = AppEnvironment.current.authManager
                        as? MockAuthManager
                else {fail("authManager should be present"); return }
                
                expect(authManager.signOut_wasCalled).to(beTrue())
                expect(delegate.userDidSignOut_wasCalled).to(beTrue())
            }
            
            it("calls delegate on delete account") {
                subject.deleteAccount()
//                expect(delegate.userDidSignOut_wasCalled).to(beTrue())
                
            }
        }
    }
}

class MockSettingsViewModelDelegate: SettingsViewModelDelegate {
    var userDidSignOut_wasCalled = false
    func userDidSignOut() {
        userDidSignOut_wasCalled = true
    }
}
