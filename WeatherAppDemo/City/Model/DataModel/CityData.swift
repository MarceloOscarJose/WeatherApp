//
//  CityData.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 20/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

struct CityData: Codable {
    var id: Int
    var name: String

    init (id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
