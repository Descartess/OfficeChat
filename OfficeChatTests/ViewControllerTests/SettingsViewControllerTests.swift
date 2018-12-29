//
//  SettingsViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class SettingsViewControllerTests: QuickSpec {
    override func spec() {
        var subject: SettingsViewController!
        var viewModel: SettingsViewModel!
        
        describe("SettingsViewController") {
            beforeEach {
                guard
                    let settingsViewController = SettingsViewController.instantiate(from: .main)
                    else { fail("SettingsViewController must not be nil"); return }
                
                viewModel = SettingsViewModel(user: Fixtures.mockUser)
                
                subject = settingsViewController
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
        }
    }
}
