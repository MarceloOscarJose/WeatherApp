//
//  WeatherData.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class WeatherData: NSObject {

    var name: String
    var icon: String
    var main: String
    var mainDescription: String
    var temp: Int
    var humidity: Int
    var windSpeed: Int
    var windDirection: String

    init(weather: Weather) {
        self.name = weather.name
        self.icon = weather.weather.first?.icon ?? ""
        self.main = weather.weather.first?.main ?? ""
        self.mainDescription = weather.weather.first?.descrip.capitalizedFirstLetter() ?? ""
        self.temp = Int(weather.main.temp.rounded())
        self.humidity = weather.main.humidity
        self.windSpeed = Int(weather.wind.speed.rounded())

        if let windDegrees = weather.wind.deg {
            self.windDirection = "\(Int(windDegrees.rounded()))°"
        } else {
            self.windDirection = "N/A"
        }
    }
}
