//
//  Citys.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 11/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

enum Citys: String {
    case brussels = "968019"
    case newYork = "2459115"
    func woeid()-> String {
        return self.rawValue
    }
}
