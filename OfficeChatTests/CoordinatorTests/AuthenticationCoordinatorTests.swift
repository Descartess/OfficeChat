//
//  AuthenticationCoordinatorTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 27/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
@testable import OfficeChat

class AuthenticationCoordinatorTests: QuickSpec {
    override func spec() {
        var subject: AuthenticationCoordinator!
        var presenter: UIWindow!
        
        describe("AuthenticationCoordinator") {
            beforeEach {
                presenter = UIWindow()
                subject = AuthenticationCoordinator(presenter: presenter)
            }
            
            it("shows MainTabBarController on start") {
                subject.start()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(LoginViewController.self))
            }
            
            it("shows MainTabBarController after log in") {
                subject.didLogin()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(MainTabBarController.self))
            }
            
            it("shows ProfileViewController on after user creation") {
                subject.didCreateNewUser()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(ProfileViewController.self))
            }
        }
    }
}
