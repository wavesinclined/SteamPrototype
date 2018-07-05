//
//  AppCoordinator.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class AppCoordinator {
    static var shared = AppCoordinator()
    
    var window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    private init() { }
    
    func start() {
        if FBSDKAccessToken.current() == nil {
            goToOnBoarding()
        } else {
            gotoHome()
        }
    }
    
    func gotoHome() {
        let home = HomeController()
        home.delegate = self
        let homeNav = UINavigationController(rootViewController: home)
        self.window.rootViewController = homeNav
        self.window.makeKeyAndVisible()
    }
    
    func goToOnBoarding() {
        let onBoardingPage = OnBoardingController()
        onBoardingPage.delegate = self
        let onBoardingNav = UINavigationController(rootViewController: onBoardingPage)
        self.window.rootViewController = onBoardingNav
        self.window.makeKeyAndVisible()
    }
    
}
