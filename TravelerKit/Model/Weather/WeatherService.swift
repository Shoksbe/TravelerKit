//
//  WeatherService.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 11/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation
import UIKit

class WeatherService {

    static let shared = WeatherService()
    private init() {}

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    private let endPoint = "https://query.yahooapis.com/v1/public/yql?q="

    init(session: URLSession) {
        self.session = session
    }

    func getWeather(of city: Citys, callback: @escaping (Bool, WeatherInfo?)-> ()) {

        //yqlQuery
        var yqlQuery = "select * from weather.forecast where woeid=\(city.woeid()) and u='c'&format=json"

        yqlQuery = yqlQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        //Settings URL
        let urlString = endPoint + yqlQuery

        guard let url = URL(string: urlString) else {
            callback(false, nil)
            return
        }

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }

                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(WeatherDecodable.self, from: data)
                    callback(true, self.getWeatherInfoFrom(obj))
                }
                catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    callback(false, nil)
                }
            }
        }
        task?.resume()
    }

    private func getWeatherInfoFrom(_ parsedData: WeatherDecodable) -> WeatherInfo {
        let weatherCondition = parsedData.query.results.channel.item.condition
        let weatherForecast = parsedData.query.results.channel.item.forecast
        let weatherLocation = parsedData.query.results.channel.location

        let city = weatherLocation.city
        let code = weatherCondition.code
        let temp = weatherCondition.temp
        let text = weatherCondition.text
        let high = weatherForecast[0].high
        let low = weatherForecast[0].low
        var icon: UIImage!
        
        if let url = URL(string: "https://s.yimg.com/zz/combo?a/i/us/we/52/\(code).gif") {
            if let data = try? Data(contentsOf: url) {
                icon = UIImage(data: data)!
            }
        }

        return WeatherInfo(
            cityName: city,
            iconCode: code,
            temp: temp,
            tempDescription: text,
            icon: icon,
            highestTemp: high,
            lowestTemp: low
        )
    }
}
