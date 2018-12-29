//
//  ProfileViewCoordinatorTests.swift
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

class ProfileViewCoordinatorTests: QuickSpec {
    override func spec() {
        var subject: ProfileCoordinator!
        var presenter: UIWindow!
        
        describe("ProfileCoordinator") {
            beforeEach {
                presenter = UIWindow()
                subject = ProfileCoordinator(presenter: presenter)
            }
            
            it("shows ProfleViewController on start") {
                subject.start()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(ProfileViewController.self))
            }
            
            it("shows MainTabBarController on after creation of user profile") {
                subject.didCreateUserProfile()
                guard
                    let viewController = presenter.rootViewController
                    else { fail("Window must have a root view controller"); return }
                expect(viewController).to(beAnInstanceOf(MainTabBarController.self))
            }
        }
    }
}
