//
//  ForecastData.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ForecastData: NSObject {

    var list: [[ForecastDataResult]] = []

    var currentData: String = ""

    init(forecast: Forecast) {

        let formatterShortDate = DateFormatter.shortDate
        let groupedForecast = Dictionary(grouping: forecast.list) { formatterShortDate.string(from: $0.dtTxt) }

        for forecastData in groupedForecast.values {
            var forecastListdata: [ForecastDataResult] = []

            for forecast in forecastData {
                forecastListdata.append(ForecastDataResult(forecast: forecast))
            }

            list.append(forecastListdata)
        }
    }
}

class ForecastDataResult: NSObject {

    var icon: String
    var main: String
    var mainDescription: String
    var temp: String
    var humidity: String
    var windSpeed: String
    var windDirection: String
    var date: String
    var dayName: String
    var hour: String

    init(forecast: ForecastList) {
        self.icon = forecast.weather.first?.icon ?? ""
        self.main = forecast.weather.first?.main ?? ""
        self.mainDescription = forecast.weather.first?.description ?? ""
        self.temp = "\(Int(forecast.main.temp.rounded()))°"
        self.humidity = "\(forecast.main.humidity)%"
        self.windSpeed = "\(Int(forecast.wind.speed.rounded())) Km/h"
        self.windDirection = "N"

        self.date = DateFormatter.longDate.string(from: forecast.dtTxt).capitalizedFirstLetter()
        self.dayName = DateFormatter.dayName.string(from: forecast.dtTxt).capitalizedFirstLetter()
        self.hour = DateFormatter.hour.string(from: forecast.dtTxt).capitalizedFirstLetter()
    }
}
