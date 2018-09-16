//
//  ConversionService.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 24/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class ConversionService {

    //Singleton
    static let shared = ConversionService()
    private init() {}

    //dependency injection to perform the tests
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }

    //Api informations
    private let apiKey = valueForAPIKey(named: "API_CLIENT_FIXER")
    private let symbols = "USD,GBP,CAD,CHF,AUD,JPY,CNY"

    func getCurrencyRates(callback: @escaping (Bool, ConversionDecodable?)-> ()) {

        let urlString = "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=EUR&symbols=\(symbols)"

        guard let url = URL(string: urlString) else {
            callback(false, nil)
            return
        }

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {

                //Check if data, no error and httpResponseCode is ok
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }

                //Decode jsonFiles
                guard let responseJSON = try? JSONDecoder().decode(ConversionDecodable.self, from: data) else {
                    callback(false, nil)
                    return
                }

                callback(true, responseJSON)
            }
        }
        task?.resume()
    }
}

