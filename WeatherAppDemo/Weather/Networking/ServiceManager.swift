//
//  ServiceManager.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Alamofire

class GeneralService: NSObject {

    public func executeRequest(url: String, paramaters: [String: AnyObject], responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error) -> Void) {

        var params = paramaters
        params["appid"] = ConfigManager.sharedInstance.apiKey as AnyObject
        params["lang"] = "es" as AnyObject
        params["units"] = "metric" as AnyObject

        if let finalURL = URL(string: "\(ConfigManager.sharedInstance.baseURL)\(url)") {
            self.executeRequest(method: .get, url: finalURL, paramaters: params, responseHandler: responseHandler, errorHandler: errorHandler)
        }
    }

    private func executeRequest(method: Alamofire.HTTPMethod, url: URL, paramaters: [String: AnyObject]?, responseHandler: @escaping (_ response: Data) -> Void, errorHandler: @escaping (_ error: Error) -> Void) {

        Alamofire.request(url, method: method, parameters: paramaters, encoding: URLEncoding.default, headers: nil).response(completionHandler: { (request) in

            if let error = request.error {
                errorHandler(error)
                return
            }

            guard let responseData = request.data, let requestResponse = request.response else {
                let responseError: Error = self.generateError(response: request)
                errorHandler(responseError)
                return
            }

            if requestResponse.statusCode != 200 {
                responseHandler(responseData)
                return
            }

            responseHandler(responseData)
            return
        })
    }

    public func generateError(response: DefaultDataResponse) -> Error {

        var responseError: Error = NSError(domain: "", code: 1, userInfo: nil)

        if let responseData = response.response {
            responseError = NSError(domain: "", code: responseData.statusCode, userInfo: nil)
        }

        return responseError
    }
}
