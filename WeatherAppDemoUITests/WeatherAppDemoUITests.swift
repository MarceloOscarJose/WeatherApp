//
//  WeatherAppDemoUITests.swift
//  WeatherAppDemoUITests
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import XCTest
@testable import WeatherAppDemo

class WeatherAppDemoUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments += ["UI-Testing"]
        app.launch()
    }

    override func tearDown() {
    }

    func testCitySelection() {
        _ = CityScreen()
            .selectCities([0 ,1 , 2, 3])
            .continueToMainScreen()
            .swipeToNextPage()
            .swipeToNextPage()
            .swipeToNextPage()
    }

    func testCityNoSelection() {
        _ = CityScreen()
            .continueWithError()
            .tapOkError()
    }

    func testCityMoreSelection() {
        _ = CityScreen()
            .selectCities([0 ,1 , 2, 3, 4, 5, 6])
            .continueWithError()
            .tapOkError()
    }
}
