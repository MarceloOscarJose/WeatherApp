//
//  ConfigManager.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/21/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ConfigManager: NSObject {
    static let sharedInstance = ConfigManager()

    // Config vars
    var baseURL = ""
    var apiKey = ""

    override init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            if let nsDictionary: NSDictionary = NSDictionary(contentsOfFile: path) {
                self.baseURL = nsDictionary["base_url"] as! String
                self.apiKey = nsDictionary["api_key"] as! String
            }
        }
    }
}
