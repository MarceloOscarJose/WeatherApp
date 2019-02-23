//
//  DateFormatter.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Foundation

extension DateFormatter {

    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter
    }()

    static let longDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter
    }()

    static let dayName: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter
    }()

    static let hour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter
    }()
}
