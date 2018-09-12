//
//  WeatherViewController.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 11/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weather: WeatherBrain!

    //LocalWeatherView
    @IBOutlet weak var localCityName: UILabel!
    @IBOutlet weak var localWeatherDescription: UILabel!
    @IBOutlet weak var localWeatherIcon: UIImageView!
    @IBOutlet weak var localTemp: UILabel!
    @IBOutlet weak var localDay: UILabel!
    @IBOutlet weak var localHighTemp: UILabel!
    @IBOutlet weak var localLowTemp: UILabel!

    //DestinationWeatherView
    @IBOutlet weak var destinationCityName: UILabel!
    @IBOutlet weak var destinationWeatherDescription: UILabel!
    @IBOutlet weak var destinationWeatherIcon: UIImageView!
    @IBOutlet weak var destinationTemp: UILabel!
    @IBOutlet weak var destinationDay: UILabel!
    @IBOutlet weak var destinationHighTemp: UILabel!
    @IBOutlet weak var destinationLowTemp: UILabel!

}

// MARK: - Methodes
extension WeatherViewController {
    override func viewDidLoad() {
        getWeatherFromApi()
    }
    
    private func getWeatherFromApi() {
        
        var local: WeatherInfo!
        var destination: WeatherInfo!
        
        //recovery of local weather information
        WeatherService.shared.getWeather(of: .brussels) { (success, weatherDetailsLocal) in
            if success, let weatherDetailsLocal = weatherDetailsLocal {
                local = weatherDetailsLocal
            } else {
                self.showAlertError(message: "Could not load local weather")
                return
            }
            
            //recovery of the destination's weather information
            WeatherService.shared.getWeather(of: .newYork) { (success, weatherDetailsDestination) in
                if success, let weatherDetailsDestination = weatherDetailsDestination {
                    destination = weatherDetailsDestination
                } else {
                    self.showAlertError(message: "Could not load destination weather")
                    return
                }
                self.weather = WeatherBrain(localWeather: local, destinationWeather: destination)
                self.setWeatherView()
            }
        }
    }

    @objc private func setWeatherView() {
        //LocalWeatherView
        let localWeather = weather.local
        
        localCityName.text = localWeather.cityName
        localWeatherDescription.text = localWeather.tempDescription
        localTemp.text = localWeather.temp + "°"
        localWeatherIcon.image = localWeather.icon
        localHighTemp.text = localWeather.highestTemp + "°"
        localLowTemp.text = localWeather.lowestTemp + "°"

        //DestinationWeather
        let destinationWeather = weather.destination
        
        destinationCityName.text = destinationWeather.cityName
        destinationWeatherDescription.text = destinationWeather.tempDescription
        destinationTemp.text = destinationWeather.temp + "°"
        destinationWeatherIcon.image = destinationWeather.icon
        destinationHighTemp.text = destinationWeather.highestTemp + "°"
        destinationLowTemp.text = destinationWeather.lowestTemp + "°"
    }

    ///Displays errors
    @objc private func showAlertError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
