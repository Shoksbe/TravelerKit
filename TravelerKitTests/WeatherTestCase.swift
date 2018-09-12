//
//  WeatherTestCase.swift
//  TravelerKitTests
//
//  Created by De knyf Gregory on 12/08/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import XCTest
@testable import TravelerKit

class WeatherTestCase: XCTestCase {

    // MARK: - WeatherBrain
    func testGivenInstanceWhenAccessingItThenIsExist() {
        //Given
        let weatherInfo = WeatherInfo(cityName: "Bruxelles",
                                    iconCode: "1",
                                    temp: "18",
                                    tempDescription: "Cloudy",
                                    icon: UIImage(),
                                    highestTemp: "25",
                                    lowestTemp: "12")
        
        let weather = WeatherBrain(localWeather: weatherInfo, destinationWeather: weatherInfo)
        
        XCTAssertNotNil(weather)
    }
    
    // MARK: - Services
    func testGetWeatherShouldPostFailed() {
        //Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(of: .brussels) { (success, weatherInfo) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherInfo)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedIfNoData() {
        //Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(of: .brussels) { (success, weatherInfo) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherInfo)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedIfInccorectResponse() {
        //Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(of: .brussels) { (success, weatherInfo) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherInfo)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedIfIncorrectData() {
        //Given
        let weatherService = WeatherService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(of: .brussels) { (success, weatherInfo) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherInfo)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccesIfCorrectDataAndNoError() {
        //Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(of: .brussels) { (success, weatherInfo) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherInfo)

            let city = weatherInfo!.cityName
            let temperature = weatherInfo!.temp
            let condition = weatherInfo!.tempDescription

            XCTAssertEqual(city, "Brussels")
            XCTAssertEqual(temperature, "16")
            XCTAssertEqual(condition, "Cloudy")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

}
