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
        let groupedForecast = Dictionary(grouping: forecast.list, by: { formatterShortDate.string(from: $0.dtTxt) }).sorted {
            if let firstData = $0.value.first, let secondData = $1.value.first {
                return firstData.dt < secondData.dt
            }

            return true
        }

        for forecastData in groupedForecast {
            var forecastListdata: [ForecastDataResult] = []
            for forecast in forecastData.value {
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
    var windDirection: String?
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

        if let windDegrees = forecast.wind.deg {
            self.windDirection = "\(Int(windDegrees.rounded()))°"
        } else {
            self.windDirection = "N/A"
        }

        self.date = DateFormatter.longDate.string(from: forecast.dtTxt).capitalizedFirstLetter()
        self.dayName = DateFormatter.dayName.string(from: forecast.dtTxt).capitalizedFirstLetter()
        self.hour = DateFormatter.hour.string(from: forecast.dtTxt).capitalizedFirstLetter()
    }
}
