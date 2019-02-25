//
//  WeatherAppDemoTests.swift
//  WeatherAppDemoTests
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import XCTest
@testable import WeatherAppDemo

class WeatherAppDemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMainModel() {
        let mainModel = MainModelMock()
        var mainDataMock: MainData!

        let expectation = self.expectation(description: "Scaling")

        mainModel.getWeather(id: 7284819, responseHandler: { (mainData) in
            mainDataMock = mainData
            expectation.fulfill()
        }) { (error) in
            XCTAssert(false)
        }

        waitForExpectations(timeout: 10, handler: nil)

        // Wheater
        XCTAssert(mainDataMock.weather.mainDescription == "Soleado")
        XCTAssert(mainDataMock.weather.humidity == "40%")
        XCTAssert(mainDataMock.weather.temp == "36°")
        XCTAssert(mainDataMock.weather.windSpeed == "10 Km/h")
        XCTAssert(mainDataMock.weather.windDirection == "240°")

        // Forecast
        XCTAssert(mainDataMock.forecast.list.first?.first?.icon == "10d")
        XCTAssert(mainDataMock.forecast.list.first?.first?.dayName == "Domingo")
        XCTAssert(mainDataMock.forecast.list.first?.first?.date == "Febrero 24, 2019")
        XCTAssert(mainDataMock.forecast.list.first?.first?.temp == "10°")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
