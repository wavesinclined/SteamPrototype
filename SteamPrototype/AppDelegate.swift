//
//  AppDelegate.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppCoordinator.shared.start()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        
        return true
    }
}

