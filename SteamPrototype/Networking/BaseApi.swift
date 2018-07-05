//
//  BaseApi.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

protocol BaseApi {
    static func requestGET<T: Decodable>(_ url: URL) -> Promise<T>
}

extension BaseApi {
    static func requestGET<T: Decodable>(_ url: URL) -> Promise<T> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared
            .dataTask(.promise, with: url)
            .map {
                try JSONDecoder().decode(T.self, from: $0.data)
            }
    }
}

