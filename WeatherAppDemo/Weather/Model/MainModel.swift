//
//  MainModel.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class MainModel: MainModelProtocol {

    var succeededData = true
    var msgData = ""

    let weatherService = WeatherService()
    let forecastService = ForecastService()

    var weatherData: WeatherData!
    var forecastData: ForecastData!

    func getWeather(id: Int, responseHandler: @escaping (_ response: MainData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let group = DispatchGroup()

        group.enter()
        weatherService.getWeather(id: id, responseHandler: { (weather) in
            self.weatherData = WeatherData(weather: weather)
            group.leave()
        }) { (error) in
            self.succeededData = false
            errorHandler(error)
        }

        group.enter()
        forecastService.getForecast(id: id, responseHandler: { (forecast) in
            self.forecastData = ForecastData(forecast: forecast)
            group.leave()
        }) { (error) in
            self.succeededData = false
            errorHandler(error)
        }

        group.notify(queue: .main) {
            let mainData = MainData(weather: self.weatherData, forecast: self.forecastData)
            responseHandler(mainData)
        }
    }
}

protocol MainModelProtocol {
    func getWeather(id: Int, responseHandler: @escaping (_ response: MainData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
