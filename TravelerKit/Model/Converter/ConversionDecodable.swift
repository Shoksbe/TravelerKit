//
//  ConversionDecodable.swift
//  TravelerKit
//
//  Created by De knyf Gregory on 24/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

struct RatesDetails: Decodable {
    let success: Bool
    let error: ResponseError?
    let date: String?
    let rates: [String:Double]?

    struct ResponseError: Error, Decodable {
        let code: Int
    }
}
