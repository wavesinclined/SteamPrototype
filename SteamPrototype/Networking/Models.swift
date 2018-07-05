//
//  Models.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation

struct AppDetailResponse: Codable {
    var success: Bool?
    var data: GameDataModel?
}

struct GameDataModel: Codable {
    var appId: Int?
    var name: String?
    var headerImage: String?
    var detailedDesc: String?
    var shortDesc: String?
    var publishers: [String]?
    var metacritic: MetaCritic?
    var screenshots: [ScreenShot]?
    var platforms: Platforms?
    
    enum CodingKeys: String, CodingKey {
        case appId = "steam_appid"
        case headerImage = "header_image"
        case name
        case detailedDesc = "detailed_description"
        case shortDesc = "short_description"
        case publishers
        case metacritic
        case screenshots
        case platforms
    }
    
    struct MetaCritic: Codable {
        var score: Int?
        var url: String?
    }
    
    struct ScreenShot: Codable {
        var id: Int?
        var pathThumbail: String?
        var pathFull: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case pathThumbail = "path_thumbnail"
            case pathFull = "path_full"
        }
    }
    
    /*
    "screenshots": [
    {
    "id": 0,
    "path_thumbnail": "https://steamcdn-a.akamaihd.net/steam/apps/271590/ss_32aa18ab3175e3002217862dd5917646d298ab6b.600x338.jpg?t=1516043170",
    "path_full": "https://steamcdn-a.akamaihd.net/steam/apps/271590/ss_32aa18ab3175e3002217862dd5917646d298ab6b.1920x1080.jpg?t=1516043170"
    },*/
}


struct PlayerStatsResponse: Codable {
    var success: Bool?
    var data: PlayerStatsData?
}

struct PlayerStatsData: Codable {
    var start: UInt?
    var step: UInt?
    var values: [UInt]?
}

struct Platforms: Codable {
    var windows: Bool?
    var mac: Bool?
    var linux: Bool?
}

/*
"platforms": {
    "windows": true,
    "mac": true,
    "linux": true
},
 */

/*
 "success": true,
 "data": {
 "start": 1530100800,
 "step": 600,
 "values": [
*/



