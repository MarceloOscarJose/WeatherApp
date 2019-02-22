//
//  Weather.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct Weather: Codable {
    var name: String
    var weather: [WeatherInfo]
    var main: WeatherMain
    var wind: WeatherWind
    var clouds: WeatherClouds
}

struct WeatherMain: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity
    }
}

struct WeatherInfo: Codable {
    var id: Int
    var main: String
    var descrip: String
    var icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case descrip = "description"
        case icon
    }
}

struct WeatherClouds: Codable {
    var all: Int
}

struct WeatherWind: Codable {
    var speed: Double
    var deg: Double?
}
