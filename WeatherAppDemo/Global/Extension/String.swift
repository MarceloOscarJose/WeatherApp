//
//  String.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/21/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import Foundation

extension String {

    func capitalizedFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
