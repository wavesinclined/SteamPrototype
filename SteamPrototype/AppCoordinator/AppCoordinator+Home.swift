//
//  AppCoordinator+Home.swift
//  SteamPrototype
//
//  Created by alice singh on 04/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import UIKit

extension AppCoordinator: HomeControllerDelegate {
    func didSelectGameItem(_ controller: UIViewController, model: GameDataModel) {
        let detailPage = GameDetailController(model: model)
        detailPage.delegate = self
        controller.navigationController?.pushViewController(detailPage, animated: true)
    }
    
    func homeControllerDidLogOut(_ controller: UIViewController) {
        goToOnBoarding()
    }
}
