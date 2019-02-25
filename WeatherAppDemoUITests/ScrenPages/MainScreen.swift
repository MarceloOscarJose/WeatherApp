//
//  MainScreen.swift
//  WeatherAppDemoUITests
//
//  Created by Marcelo José on 25/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Foundation

class MainScreen: BaseScreen {

    private lazy var forecastCell = collectionView()

    override open func waitForElements() {
        waitFor(element: forecastCell)
    }

    func swipeToNextPage() -> MainScreen {
        forecastCell.swipeLeft()
        return MainScreen()
    }
}
