//
//  ForecastService.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ForecastService: GeneralService {

    let forecastURL = "forecast/"

    func getForecast(id: Int, responseHandler: @escaping (_ response: Forecast) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {

        let parameters: [String: Int] = ["id": id]

        self.executeRequest(url: self.forecastURL, paramaters: parameters as [String : AnyObject], responseHandler: { (data) in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)

                let forecastResult = try decoder.decode(Forecast.self, from: data)
                responseHandler(forecastResult)
            } catch {
                errorHandler(NSError(domain: error.localizedDescription, code: 1001, userInfo: nil))
            }
        }) { (error) in
            errorHandler(error)
        }
    }
}
