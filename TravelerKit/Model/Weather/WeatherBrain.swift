//
//  Weather.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 11/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class WeatherBrain {

    // MARK: - Properties
    var local: WeatherInfo?
    var destination: WeatherInfo?
    
    private var error: String? {
        didSet {
            //Make alert on controller
            NotificationCenter.default.post(name: .errorTranslate, object: nil, userInfo: ["error": error!])
        }
    }

    // MARK: - Initialiser
    init() {
        getWeatherFromApi()
    }

    // MARK: - Methods
    private func getWeatherFromApi() {

        //recovery of local weather information
        WeatherService.shared.getWeather(of: .brussels) { (success, weatherDetailsLocal) in
            if success, let weatherDetailsLocal = weatherDetailsLocal {
                self.local = weatherDetailsLocal
            } else {
                self.error = "Could not load local weather"
                return
            }

            //recovery of the destination's weather information
            WeatherService.shared.getWeather(of: .newYork) { (success, weatherDetailsDestination) in
                if success, let weatherDetailsDestination = weatherDetailsDestination {
                    self.destination = weatherDetailsDestination
                } else {
                    self.error = "Could not load destination weather"
                    return
                }

                //Notify the controller that the weather is loaded
                NotificationCenter.default.post(name: .weatherLoaded, object: nil)
            }
        }
    }
}
