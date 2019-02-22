//
//  WeatherData.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MainData: NSObject {

    var weather: WeatherData
    var forecast: ForecastData

    init(weather: WeatherData, forecast: ForecastData) {
        self.weather = weather
        self.forecast = forecast
    }
}
