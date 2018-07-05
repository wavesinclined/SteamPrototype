//
//  GameShortModel.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation

struct GameShortModel {
    var gameId: String
    var name: String
    var imageUrlString: String?
    var players: String?
}

struct PlayerShortModel {
    var gameId: String
    var currentPlayer: String
}
