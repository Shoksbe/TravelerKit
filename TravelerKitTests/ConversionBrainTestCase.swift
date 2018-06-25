//
//  ConversionBrainTestCase.swift
//  TravelerKitTests
//
//  Created by De knyf Gregory on 24/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import XCTest
@testable import TravelerKit

class ConversionBrainTestCase: XCTestCase {

    var conversionBrain: ConversionBrain!

    override func setUp() {
        conversionBrain = ConversionBrain()
    }

    // MARK: - ConversionBrain
    func testGiven5ToUnConvertedAmountWhenAccessingItThenIsValueEqual5() {
        conversionBrain.addNumber("5")

        XCTAssertEqual(conversionBrain.unConvertedAmount, "5")
    }

    func testGiven8Comma1NumberToUnConvertedAmountWhenAccessingItTheIsValueEquel8Comma1() {
        conversionBrain.addNumber("8")
        conversionBrain.addComma()
        conversionBrain.addNumber("1")

        XCTAssertEqual(conversionBrain.unConvertedAmount, "8.1")
    }

    func testGivenNoEmptyUnconvertedAmountWhenResetToZeroThenUnconvertedAmoundIsEmpty() {
        conversionBrain.addNumber("8")
        conversionBrain.addComma()
        conversionBrain.addNumber("1")

        conversionBrain.resetToZero()

        XCTAssertTrue(conversionBrain.unConvertedAmount.isEmpty)
    }

    // MARK: - Service
    func testGetCurrencyShouldPostFailedCallback() {
        // Given
        let conversionService = ConversionService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getCurrencyRates { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        // Given
        let conversionService = ConversionService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getCurrencyRates { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getCurrencyRates { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getCurrencyRates { (success, currency) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let conversionService = ConversionService(
            session: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        conversionService.getCurrencyRates { (success, currency) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)

            let rates = [
                "USD": 1.160491,
                "GBP": 0.873479,
                "CAD": 1.531737,
                "CHF": 1.15744,
                "AUD": 1.559241,
                "JPY": 128.390942,
                "CNY": 7.471015
            ]

            XCTAssertEqual(rates, currency!.rates)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
