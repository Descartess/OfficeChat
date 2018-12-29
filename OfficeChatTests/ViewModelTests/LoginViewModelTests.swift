//
//  LoginViewModelTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import OfficeChat

class LoginViewModelTests: QuickSpec {
     override func spec() {
        describe("Login View Model") {
            var subject: LoginViewModel!
            
            beforeEach {
                subject = LoginViewModel()
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
            }
            
            it("validates provided email") {
                expect(subject.checkValidEmail("paul@test.com")).to(beTrue())
                expect(subject.checkValidEmail("")).to(beFalse())
                expect(subject.checkValidEmail("paultest.com")).to(beFalse())
                expect(subject.checkValidEmail("paul@testcom")).to(beFalse())
                expect(subject.checkValidEmail("paultestcom")).to(beFalse())
            }
            
            it("validates password length") {
                expect(subject.checkPasswordLength("qwe")).to(beFalse())
                expect(subject.checkPasswordLength("qwertyuiop")).to(beTrue())
            }
            
            it("logs in with correct arguments") {
                subject.signInUser(email: Fixtures.userEmail, password: Fixtures.userPassword) { _ in
                    
                }
                
                guard
                    let authManager = AppEnvironment.current.authManager as? MockAuthManager,
                    let (email, password) = authManager.signIn_wasCalled_withArgs
                else { return }
                
                expect(email).to(equal(Fixtures.userEmail))
                expect(password).to(equal(Fixtures.userPassword))
            }
            
            it("creates user with correct arguments") {
                subject.createUser(email: Fixtures.userEmail, password: Fixtures.userPassword) { _ in
                    
                }
                
                guard
                    let authManager = AppEnvironment.current.authManager as? MockAuthManager,
                    let (email, password) = authManager.createUser_wasCalled_withArgs
                    else { return }
                
                expect(email).to(equal(Fixtures.userEmail))
                expect(password).to(equal(Fixtures.userPassword))
            }
        }
    }
}
