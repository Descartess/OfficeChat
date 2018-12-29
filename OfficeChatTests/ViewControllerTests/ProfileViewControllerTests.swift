//
//  ProfileViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class ProfileViewControllerTests: QuickSpec {
    override func spec() {
        var subject: ProfileViewController!
        var viewModel: ProfileViewModel!
        
        describe("ProfileViewController") {
            beforeEach {
                guard
                    let profileViewController = ProfileViewController.instantiate(from: .main)
                    else { fail("ProfileViewController must not be nil"); return }
                
                viewModel = ProfileViewModel(user: Fixtures.mockUser)
                
                subject = profileViewController
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
        }
    }
}
