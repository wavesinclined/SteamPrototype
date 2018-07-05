//
//  GameApi.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import PromiseKit

class GameApi: BaseApi {
    static func gameGET(_ appId: String) -> Promise<GameDataModel> {
        // 1. create url
        guard var urlComponents = URLComponents(string: ApiConstant.appDetailUrl) else {
            return Promise(error: ApiError.invalidUrl)
        }
        
        //https://store.steampowered.com/api/appdetails/?appids=271590
        urlComponents.queryItems = [
            URLQueryItem(name: "appids", value: appId)
        ]
        
        guard let url = urlComponents.url else {
            return Promise(error: ApiError.invalidUrl)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return URLSession.shared.dataTask(.promise, with: url).then { (data, response) -> Promise<GameDataModel> in

            
            do { // parse data
                let mainModel: [String: AppDetailResponse] = try JSONDecoder().decode([String: AppDetailResponse].self, from: data)
                if let detail = mainModel[appId], let model = detail.data {
                    return .value(model)
                }
                return Promise(error: ApiError.noResult)
            } catch let error {
                print(error)
                return Promise(error: ApiError.parsing)
            }
        }
    }

    static func currentPlayers(_ appId: String) -> Promise<String> {
        return createGameStatsUrl(appId)
            .then {
                URLSession.shared.dataTask(.promise, with: $0)
            }.map {
                try JSONDecoder().decode(PlayerStatsResponse.self, from: $0.data)
            }.then { response -> Promise<String>  in
                if let data = response.data, let players = data.values?.last {
                    return .value(String(players))
                }
                
                throw ApiError.noResult
            }
    }
}

extension GameApi {
    fileprivate static func createGameStatsUrl(_ appId: String) -> Promise<URLRequest> {
        guard var urlComponents = URLComponents(string: ApiConstant.playerStatsUrl) else {
            return Promise(error: ApiError.invalidUrl)
        }
        
        //https://steamdb.info/api/GetGraph/?type=concurrent_week&appid=826230 
        urlComponents.queryItems = [
            URLQueryItem(name: "type", value: "concurrent_week"),
            URLQueryItem(name: "appid", value: appId)
        ]
        
        guard let url = urlComponents.url else {
            return Promise(error: ApiError.invalidUrl)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return .value(request)
    }
}
