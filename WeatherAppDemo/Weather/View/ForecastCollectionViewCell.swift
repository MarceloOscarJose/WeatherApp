//
//  ForecastCollectionViewCell.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var forecastIcon: UIImageView!
    @IBOutlet weak var forecastTemp: UILabel!
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastDayName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCellData(image: String, temp: String, date: String, dayName: String) {
        forecastIcon.image = UIImage(named: image)
        forecastTemp.text = temp
        forecastDate.text = date
        forecastDayName.text = dayName
    }
}
