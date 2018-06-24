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

    func testGiven5ToUnConvertedAmountWhenAccessingItThenIsValueEqual5() {
        let conversionBrain = ConversionBrain()
        conversionBrain.addNumber("5")

        XCTAssertEqual(conversionBrain.unConvertedAmount, "5")
    }
}
