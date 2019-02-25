//
//  MainModelMock.swift
//  WeatherAppDemoTests
//
//  Created by Marcelo José on 21/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Foundation
@testable import WeatherAppDemo

class MainModelMock: MainModelProtocol {

    func getWeather(id: Int, responseHandler: @escaping (MainData) -> Void, errorHandler: @escaping (Error?) -> Void) {
        let mainData = MainData(weather: createWeatherData(), forecast: createForecastData())
        responseHandler(mainData)
    }

    func createWeatherData() -> WeatherData {
        let weatherInfo = WeatherInfo(id: 1, main: "Soleado", descrip: "Soleado", icon: "10d")
        let weatherMain = WeatherMain(temp: 35.5, tempMin: 35.5, tempMax: 35.5, pressure: 1000, humidity: 40)
        let weatherWind = WeatherWind(speed: 10, deg: 240)
        let weatherMock = Weather(name: "Buenos Aires", weather: [weatherInfo], main: weatherMain, wind: weatherWind)

        return WeatherData(weather: weatherMock)
    }

    func createForecastData() -> ForecastData {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "2019-02-24") ?? Date()

        let forecastMainMock = ForecastMain(temp: 10, tempMin: 10, tempMax: 10, pressure: 1000, humidity: 40, tempKf: 10)
        let forecastWeatherMock = ForecastWeather(id: 1, main: "soleado", description: "soleado", icon: "10d")
        let forecastWindMock = ForecastWind(speed: 10, deg: 240)
        let forecastListMock = ForecastList(main: forecastMainMock, weather: [forecastWeatherMock], wind: forecastWindMock, dtTxt: date, dt: 15123)
        let forecastMock = Forecast(cnt: 1, list: [forecastListMock])
        let forecastData = ForecastData(forecast: forecastMock)

        return forecastData
    }
}
