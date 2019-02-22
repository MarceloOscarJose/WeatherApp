//
//  WeatherServiceMock.swift
//  WeatherAppDemoTests
//
//  Created by Marcelo José on 21/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

@testable import WeatherAppDemo

extension WeatherService {

    func getWeather(id: Int, responseHandler: @escaping (_ response: Weather) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        let weatherInfo = WeatherInfo(id: 1, main: "Soleado", descrip: "Soleado", icon: "10d")
        let weatherMain = WeatherMain(temp: 35.5, tempMin: 35.5, tempMax: 35.5, pressure: 1000, humidity: 40)
        let weatherWind = WeatherWind(speed: 10, deg: 240)
        let weatherClouds = WeatherClouds(all: 0)
        let weatherMock = Weather(name: "Buenos Aires", weather: [weatherInfo], main: weatherMain, wind: weatherWind, clouds: weatherClouds)
        responseHandler(weatherMock)
    }
}
