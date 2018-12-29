//
//  AppCoordinatorTests.swift
//  OfficeChatTests
//
//  Created by Paul Nyondo on 18/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
@testable import OfficeChat

class AppCoordinatorTests: QuickSpec {
    override func spec() {
        var subject: AppCoordinator!
        var window: UIWindow!
        
        describe("AppCoordinator with no user set") {
            beforeEach {
                window = UIWindow()
                subject = AppCoordinator(window: window)
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
            }
            
            it("shows login view controller") {
                subject.start()
                guard
                    let viewController = window.rootViewController
                else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(LoginViewController.self))
            }
        }
        
        describe("AppCoordinator with user set") {
            beforeEach {
                window = UIWindow()
                subject = AppCoordinator(window: window)
                AppEnvironment.pushEnvironment(env: Fixtures.testEnvironment)
                Fixtures.createUser()
            }

            it("shows main tab bar controller") {
                subject.start()
                guard
                    let viewController = window.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(MainTabBarController.self))
            }
        }
    }
}
