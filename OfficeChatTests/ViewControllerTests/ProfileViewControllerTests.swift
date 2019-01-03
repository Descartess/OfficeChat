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
        var delegate: MockProfileCoordinatorDelegate!
        
        describe("ProfileViewController") {
            beforeEach {
                guard
                    let profileViewController = ProfileViewController.instantiate(from: .main)
                    else { fail("ProfileViewController must not be nil"); return }
                
                viewModel = ProfileViewModel(user: Fixtures.mockUser)
                
                subject = profileViewController
                subject.loadView()
                delegate = MockProfileCoordinatorDelegate()
                subject.delegate = delegate
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
            
            it(" validates input ") {
                subject.saveButton.sendActions(for: .touchUpInside)
                expect(delegate.didCreateUserProfile_wasCalled).toEventually(beFalse())
            }
            
            it(" calls delegate when save action is tapped") {
                subject.displayNameTextField.text = "Paul Nyondo"
                subject.saveButton.sendActions(for: .touchUpInside)
                expect(delegate.didCreateUserProfile_wasCalled).toEventually(beTrue())
            }
        }
    }
}

class MockProfileCoordinatorDelegate:ProfileCoordinatorDelegate {
    var didCreateUserProfile_wasCalled = false
    func didCreateUserProfile() {
        didCreateUserProfile_wasCalled = true
    }
}
