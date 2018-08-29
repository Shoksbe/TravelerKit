//
//  WeatherDecodable.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 10/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

struct WeatherDecodable: Decodable {
    struct Query: Decodable {
        struct Result: Decodable {
            struct Channel: Decodable {
                struct Location: Decodable {
                    let city: String
                }
                let location : Location
                struct Item: Decodable {
                    struct Condition: Decodable {
                        let code: String
                        let temp: String
                        let text: String
                    }
                    let condition: Condition
                    struct Forecast: Decodable {
                        let code: String
                        let date: String
                        let day: String
                        let high: String
                        let low: String
                        let text: String
                    }
                    let forecast: [Forecast]
                }
                let item: Item
            }
            let channel: Channel
        }
        let created: String
        let results: Result
    }
    let query: Query
}
