//
//  FakeResponseData.swift
//  P9Tests
//
//  Created by De knyf Gregory on 17/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data

    //Currency data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CurrencyRate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class QuoteError: Error {}
    static let error = QuoteError()
}
