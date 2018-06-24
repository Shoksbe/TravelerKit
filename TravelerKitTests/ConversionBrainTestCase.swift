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
}
