//
//  LoginViewControllerTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 29/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import OfficeChat

class LoginViewControllerTests: QuickSpec {
    override func spec() {
        var subject: LoginViewController!
        var viewModel: LoginViewModel!
        
        describe("LoginViewController") {
            beforeEach {
                guard
                    let loginViewController = LoginViewController.instantiate(from: .main)
                    else { fail("LoginViewController must not be nil"); return }
                
                viewModel = LoginViewModel()
                
                subject = loginViewController
                subject.viewModel = viewModel
            }
            
            it("view is present ") {
                expect(subject.view).toNot(beNil())
            }
        }
    }
}
