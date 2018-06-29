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

    var convertedAmount: String {
        return convertToTargetCurrency(unConvertedAmount)
    }

    ///the name of each available currency
    var ratesName = [String]() {
        didSet {
            NotificationCenter.default.post(name: .currencyLoaded, object: nil)
        }
    }

    private var error: String? {
        didSet {
            //Make alert on controller
            NotificationCenter.default.post(name: .errorCurrency, object: nil, userInfo: ["error":error!])
        }
    }

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

    init() {
        getCurrencyRates()
    }

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

    /// Change the currency used for the conversion
    ///
    /// - Parameter newCurrency: The new currency to use
    func changeTargetCurrency(to newCurrency: String) {
        self.targetCurrency = newCurrency
    }

    private func getCurrencyRates() {
        ConversionService.shared.getCurrencyRates { (success, request) in

            //If the service call has worked and the API has returned the rates
            if success, let rates = request?.rates {
                self.currencyRates = rates
                self.ratesName = Array(rates.keys)
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

        guard let rate: Double = currencyRates?[targetCurrency] else {
            self.error = "Rate unavailable, please check your connection or reload the page."
            return ""
        }

        guard let amountToConvert: Double = Double(amount) else { return "" }

        //The conversion is done only if the rate exists
        var currencyConvert: Double = 0.0

        currencyConvert = amountToConvert * rate
        currencyConvert = currencyConvert.rounded(toPlaces: 2)

        return String(currencyConvert)
    }
}
