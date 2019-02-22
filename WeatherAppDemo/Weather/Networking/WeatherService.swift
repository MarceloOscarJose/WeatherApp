//
//  WeatherService.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class WeatherService: GeneralService {

    let weatherURL = "weather/"

    func getWeather(id: Int, responseHandler: @escaping (_ response: Weather) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: Int] = ["id": id]

        self.executeRequest(url: self.weatherURL, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let weatherResult = try JSONDecoder().decode(Weather.self, from: data)
                responseHandler(weatherResult)
            } catch {
                errorHandler(NSError(domain: error.localizedDescription, code: 1001, userInfo: nil))
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
