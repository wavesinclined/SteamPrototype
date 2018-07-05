//
//  AppAuth.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import PromiseKit

class AppAuth {
    static var shared = AppAuth()
    private init() {}
}

// public
extension AppAuth {
    func facebookLogin(from: UIViewController) -> Promise<Void> {
        return getFacebookAuthentication(from: from)
    }
    
    func faceBookLogout() throws {
          FBSDKLoginManager().logOut()
    }
}

extension FBSDKLoginManager {
    func logIn(withReadPermissions permission: [Any]!, from: UIViewController) -> Promise<FBSDKLoginManagerLoginResult> {
        return Promise { seal in
            logIn(withReadPermissions: permission, from: from) { (result, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                
                if result?.isCancelled == true {
                    seal.reject(ApiError.custom("user cancelled Facebook login"))
                    return
                }
                
                if let res = result {
                    seal.fulfill(res)
                    return
                }
                
                seal.reject(ApiError.noResult)
                return
            }
        }
    }
}

extension AppAuth {
    
    fileprivate func getFacebookAuthentication(from: UIViewController) -> Promise<Void> {
        let permissions = ["email", "public_profile"]
        
        return FBSDKLoginManager().logIn(withReadPermissions: permissions,
                                         from: from).asVoid()
    }
}

