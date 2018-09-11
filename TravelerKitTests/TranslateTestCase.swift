//
//  TranslateTestCase.swift
//  TravelerKitTests
//
//  Created by Gregory De knyf on 1/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import XCTest

@testable import TravelerKit

class TranslateTestCase: XCTestCase {
    
    // MARK: - Services
    func testGetTRanslateShouldPostFailed() {
        //Given
        let translateService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(of: "", to: "en") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(of: "", to: "en") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        //Given
        let translateService = TranslateService(
            session: URLSessionFake(data: FakeResponseData.translateCorrectDate, response: FakeResponseData.responseKO, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(of: "", to: "en") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        //Given
        let translateService = TranslateService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(of: "", to: "en") { (success, translation) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.02)
    }
    
    func testGetTranslateShouldPostSuccessCallbackIfCorrectDataAndNoError() {
        //Given
        let translateService = TranslateService(
            session: URLSessionFake(data: FakeResponseData.translateCorrectDate, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(of: "", to: "en") { (success, translation) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            
            let translatedText = "I translate with the Google API"
            
            XCTAssertEqual(translatedText, translation)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.02)
    }
    
}
