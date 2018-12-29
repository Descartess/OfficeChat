//
//  MainScreenCoordinatorTests.swift
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

class MainScreenCoordinatorTests: QuickSpec {
    override func spec() {
        var subject: MainScreenCoordinator!
        var presenter: UIWindow!
        
        describe("MainScreenCoordinator") {
            beforeEach {
                presenter = UIWindow()
                subject = MainScreenCoordinator(presenter: presenter)
            }
            
            it("shows MainTabBarController on start") {
                subject.start()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(MainTabBarController.self))
            }
            
            it("shows LoginViewController  on after user sign out") {
                subject.userDidSignOut()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(LoginViewController.self))
            }
        }
    }
}

