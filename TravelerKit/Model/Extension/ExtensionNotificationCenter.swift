//
//  ExtensionNotificationCenter.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 27/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    //Converter
    static let errorCurrency = Notification.Name("ErrorCurrency")
    static let currencyLoaded = Notification.Name("CurrencyLoaded")
    
    //Translate
    static let errorTranslate = Notification.Name("ErrorTranslate")
    static let textTranslated = Notification.Name("TextTranslated")

    //Weather
    static let errorWeather = Notification.Name("ErrorWeather")
    static let weatherLoaded = Notification.Name("WeatherLoaded")
}
