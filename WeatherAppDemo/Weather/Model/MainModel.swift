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

    let weatherService = WeatherService()
    let forecastService = ForecastService()

    var weatherData: WeatherData!
    var forecastData: ForecastData!

    func getWeather(id: Int, responseHandler: @escaping (_ response: MainData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let group = DispatchGroup()

        group.enter()
        weatherService.getWeather(id: id, responseHandler: { (weather) in
            self.weatherData = WeatherData(weather: weather)
            self.succeededData = true
            group.leave()
        }) { (error) in
            self.succeededData = false
            errorHandler(error)
            group.leave()
        }

        group.enter()
        forecastService.getForecast(id: id, responseHandler: { (forecast) in
            self.forecastData = ForecastData(forecast: forecast)
            self.succeededData = true
            group.leave()
        }) { (error) in
            self.succeededData = false
            errorHandler(error)
            group.leave()
        }

        group.notify(queue: .main) {
            if self.succeededData {
                let mainData = MainData(weather: self.weatherData, forecast: self.forecastData)
                responseHandler(mainData)
            } else {
                let responseError: Error = NSError(domain: "", code: 1, userInfo: nil)
                errorHandler(responseError)
            }
        }
    }
}

protocol MainModelProtocol {
    func getWeather(id: Int, responseHandler: @escaping (_ response: MainData) -> Void, errorHandler: @escaping (_ error: Error?) -> Void)
}
