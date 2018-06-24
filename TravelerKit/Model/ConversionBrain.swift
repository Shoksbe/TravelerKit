//
//  ConvesionBrain.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 24/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation
class ConversionBrain {

    /*This variable is used to store the amount to be converted,
     it is equal to the amount displayed in the textField of the original currency.*/
    var unConvertedAmount: String = ""

    /// Add a number to the unConvertedAmount string
    ///
    /// - Parameter number: The *String* number to add
    func addNumber(_ number: String) {
        unConvertedAmount += number
    }

    /// Add comma to the unconverted amount
    func addComma() {
        if unConvertedAmount.range(of: ".") == nil {
            unConvertedAmount += "."
        }
    }

    /// Clears the unConvertedAmount string.
    func resetToZero() {
        unConvertedAmount = ""
    }
}
