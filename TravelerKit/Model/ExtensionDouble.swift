//
//  ExtensionDouble.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 27/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
