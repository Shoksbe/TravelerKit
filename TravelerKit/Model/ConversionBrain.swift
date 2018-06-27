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

    private var error: String?

    /// Currencies and their exchange rate
    private var currencyRates: [String: Double]?

    ///The target currency used to convert, by default its USD
    private var targetCurrency = "USD"

    /*
    Manual storage of all possible error codes because the API
     does not provide a description of the error each time.
    */
    private let errorCodeDescription =
        [404:"The requested resource does not exist.",
         101:"No API Key was specified or an invalid API Key was specified.",
         103:"The requested API endpoint does not exist.",
         104:"The maximum allowed API amount of monthly API requests has been reached.",
         105:"The current subscription plan does not support this API endpoint.",
         106:"The current request did not return any results.",
         102:"The account this API request is coming from is inactive.",
         201:"An invalid base currency has been entered.",
         202:"One or more invalid symbols have been specified.",
         301:"No date has been specified.",
         302:"An invalid date has been specified.",
         403:"No or an invalid amount has been specified.",
         501:"No or an invalid timeframe has been specified.",
         502:"No or an invalid \"start_date\" has been specified.",
         503:"No or an invalid \"end_date\" has been specified.",
         504:"An invalid timeframe has been specified.",
         505:"The specified timeframe is too long, exceeding 365 days."
    ]

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


    func getCurrencyRates() {
        ConversionService.shared.getCurrencyRates { (success, request) in

            //If the service call has worked and the API has returned the rates
            if success, let rates = request?.rates {
                self.currencyRates = rates
            } else {

                //Check if there is an error in the API request
                guard let error = request?.error else {
                    self.error = "Error from service"
                    return
                }

                //Check if there is a description of the error with the error code of the API
                guard let errorFromApiDescription = self.errorCodeDescription [error.code] else {
                    self.error = "Unknow error"
                    return
                }

                self.error = errorFromApiDescription
            }
        }
    }

    // -MARK: Methodes
    /// Convert an amount from the source currency to the target currency
    ///
    /// - Parameter amount: The amount to convert
    /// - Returns: The converted amount in the new currency
    private func convertToTargetCurrency(_ amount: String)-> String {

        guard let amountToConvert: Double = Double(amount) else {
            self.error = "Unable to convert amount to a Double."
            return ""
        }

        guard let rate: Double = currencyRates?[targetCurrency] else {
            self.error = "Rate unavailable, please choose another one or reload the page."
            return ""
        }

        //The conversion is done only if the rate exists
        var currencyConvert: Double = 0.0
        currencyConvert = amountToConvert * rate
        currencyConvert = currencyConvert.rounded(toPlaces: 2)

        return String(currencyConvert)
    }
}
