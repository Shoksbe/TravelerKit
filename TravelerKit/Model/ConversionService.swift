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

    enum Result {
        case success(RatesDetails)
        case failure(String)
    }

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    func getCurrencyRates(callback: @escaping (Result)-> ()) {

        let apiKey = valueForAPIKey(named: "API_CLIENT_FIXER")
        let symbols = "USD,GBP,CAD,CHF,AUD,JPY,CNY"
        let urlString = "http://data.fixer.io/api/latest?access_key=\(apiKey)&base=EUR&symbols=\(symbols)"

        guard let url = URL(string: urlString) else {
            callback(.failure("An error occurred while creating the url."))
            return
        }

        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(.failure("An error occurred while retrieving data."))
                        return
                }

                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(RatesDetails.self, from: data)
                    callback(self.getDetails(from: obj))
                }
                catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                    callback(.failure("An error occurred while decoding."))
                }
            }
        }
        task?.resume()
    }

    private func getDetails(from request: RatesDetails) -> Result {

        /*
         Added all manually available error codes because the API
         does not provide a description of the error each time.
         */
        let errorCodeDescription =
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

        guard let error = request.error else {
            return .success(request)
        }

        guard let errorDescription = errorCodeDescription[error.code] else {
            return .failure("An unknown error occurred")
        }

        return .failure(errorDescription)

    }
}

