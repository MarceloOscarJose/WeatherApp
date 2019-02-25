//
//  CityScreen.swift
//  WeatherAppDemoUITests
//
//  Created by Marcelo José on 25/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Foundation

class CityScreen: BaseScreen {

    private lazy var nextButton = button("Siguiente")

    override open func waitForElements() {
        waitFor(element: nextButton)
    }

    func selectCities(_ rows: [Int]) -> CityScreen {
        for row in rows {
            cellNumber(row).tap()
        }

        return self
    }

    func continueToMainScreen() -> MainScreen {
        nextButton.tap()
        return MainScreen()
    }
}
