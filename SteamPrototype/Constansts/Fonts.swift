//
//  Fonts.swift
//  SteamPrototype
//
//  Created by alice singh on 03/07/18.
//  Copyright © 2018 alice singh. All rights reserved.
//

import Foundation
import UIKit

enum Fonts: String {
    case helvetica = "Helvetica"
    case helveticaBold = "Helvetica-Bold"
}

extension Fonts {
    func of(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
