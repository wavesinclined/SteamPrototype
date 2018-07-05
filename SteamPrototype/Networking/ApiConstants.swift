//
//  File.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

enum ApiConstant {
    static let appDetailUrl = "https://store.steampowered.com/api/appdetails/"
    static let playerStatsUrl = "https://steamdb.info/api/GetGraph/"
}

enum ApiError: Error {
    case invalidUrl
    case custom(String)
    case noResult
    case parsing
}
