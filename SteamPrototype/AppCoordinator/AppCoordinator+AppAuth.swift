//
//  AppCoordinator+AppAuth.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import UIKit
extension AppCoordinator: OnBoardingControllerDelegate {
    func OnBoardingControllerDidSuccessfullFacebookLogin(_ controller: UIViewController) {
        gotoHome()
    }
    
}
