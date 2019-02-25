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
    private lazy var okButton = alertButton("OK")

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

    func continueWithError() -> CityScreen {
        nextButton.tap()
        return self
    }

    func tapOkError() -> CityScreen {
        okButton.tap()
        return self
    }
}
