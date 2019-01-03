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
        var authenticationCoordinatorDelegate: MockAuthenticationCoordinatorDelegate!
        
        describe("LoginViewController") {
            beforeEach {
                guard
                    let loginViewController = LoginViewController.instantiate(from: .main)
                    else { fail("LoginViewController must not be nil"); return }
                
                viewModel = LoginViewModel()
                
                subject = loginViewController
                authenticationCoordinatorDelegate = MockAuthenticationCoordinatorDelegate()
                subject.authenticationCoordinatorDelegate = authenticationCoordinatorDelegate
                subject.viewModel = viewModel
                subject.loadView()

            }
            
            it("view is present") {
                expect(subject.view).toNot(beNil())
            }
            
            describe("") {
                
            }

            it("calls delegate on sign up") {

            }
            
            describe("on sign in with correct credentials") {
                beforeEach {
                    subject.emailField.text = "paul@test.com"
                    subject.passwordField.text = "qwertyuiop"
                    subject.signIn.sendActions(for: .touchUpInside)
                }
                
                it("calls delegate") {
                    expect(authenticationCoordinatorDelegate.didLogin_wasCalled).toEventually(beTrue())
                }
            }
            
            describe("on sign in with incorrect email") {
                beforeEach {
                    subject.emailField.text = "paul@"
                    subject.passwordField.text = "qwertyuiop"
                    subject.signIn.sendActions(for: .touchUpInside)
                }
                
                it(" doesnt call delegate") {
                    expect(authenticationCoordinatorDelegate.didLogin_wasCalled).toEventually(beFalse())
                }
            }
            
            describe("on sign in with password too short") {
                beforeEach {
                    subject.emailField.text = "paul@"
                    subject.passwordField.text = ""
                    subject.signIn.sendActions(for: .touchUpInside)
                }
                
                it(" doesnt call delegate") {
                    expect(authenticationCoordinatorDelegate.didLogin_wasCalled).toEventually(beFalse())
                }
            }
            
            describe("on sign in with correct credentials") {
                beforeEach {
                    subject.emailField.text = "paul@test.com"
                    subject.passwordField.text = "qwertyuiop"
                    subject.signUp.sendActions(for: .touchUpInside)
                }
                
                it("calls delegate") {
                    expect(authenticationCoordinatorDelegate.didCreateNewUser_wasCalled).toEventually(beTrue())
                }
            }
        }
    }
}

class MockAuthenticationCoordinatorDelegate: AuthenticationCoordinatorDelegate {
    var didCreateNewUser_wasCalled = false
    var didLogin_wasCalled = false
    
    func didCreateNewUser() {
        didCreateNewUser_wasCalled = true
    }
    func didLogin() {
        didLogin_wasCalled = true
    }
}
