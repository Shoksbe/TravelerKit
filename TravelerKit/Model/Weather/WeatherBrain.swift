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
    var local: WeatherInfo
    var destination: WeatherInfo

    // MARK: - Initialiser
    init(localWeather: WeatherInfo, destinationWeather: WeatherInfo) {
        self.local = localWeather
        self.destination = destinationWeather
    }
}
