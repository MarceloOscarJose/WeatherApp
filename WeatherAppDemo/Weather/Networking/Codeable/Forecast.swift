//
//  Forecast.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct Forecast: Codable {
    var cnt: Int
    var list: [ForecastList]
}

struct ForecastList: Codable {
    var main: ForecastMain
    var weather: [ForecastWeather]
    var wind: ForecastWind
    var dtTxt: Date

    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case wind
        case dtTxt = "dt_txt"
    }
}

struct ForecastMain: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Int
    var tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct ForecastWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct ForecastWind: Codable {
    var speed: Double
    var deg: Double
}
