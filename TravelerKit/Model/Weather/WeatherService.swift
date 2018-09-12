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

    //Singleton
    static let shared = WeatherService()
    private init() {}

    //dependency injection to perform the tests
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    //Api Url
    private let weatherUrl = URL(string: "https://query.yahooapis.com/v1/public/yql?")!

    //API call
    func getWeather(of city: Citys, callback: @escaping (Bool, WeatherInfo?)-> ()) {

        //Create request
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        
        //add the body of the request
        let body = "q=select * from weather.forecast where woeid=\(city.woeid()) and u='c'&format=json"
        request.httpBody = body.data(using: .utf8)

        //Stop the current task if there is one so that you do not run multiple tasks at the same time
        task?.cancel()
        
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                //Check if data, no error and httpResponseCode is ok
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }
                
                //Decode jsonFiles
                guard let responseJSON = try? JSONDecoder().decode(WeatherDecodable.self, from: data) else {
                        callback(false, nil)
                        return
                }
                
                callback(true, self.getWeatherInfoFrom(responseJSON))
            }
        }
        //Launch task
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
