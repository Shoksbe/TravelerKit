//
//  ConversionService.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 24/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class ConversionService {

    static let shared = ConversionService()
    private init() {}

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    func getCurrencyRates(callback: @escaping (Bool, RatesDetails?)-> ()) {

        let apiKey = valueForAPIKey(named: "API_CLIENT_FIXER")
        let symbols = "USD,GBP,CAD,CHF,AUD,JPY,CNY"
        let urlString = "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=EUR&symbols=\(symbols)"

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
                    let obj = try decoder.decode(RatesDetails.self, from: data)
                    callback(true, obj)
                }
                catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    callback(false, nil)
                }
            }
        }
        task?.resume()
    }
}

