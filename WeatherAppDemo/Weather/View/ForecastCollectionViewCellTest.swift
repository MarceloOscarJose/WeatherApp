//
//  ForecastCollectionViewCell.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ForecastCollectionViewCellTest: UICollectionViewCell {

    @IBOutlet weak var forecastDayName: UILabel!
    @IBOutlet weak var forecastContainer: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCellData(image: String, temp: Int, date: String, dayName: String) {

        forecastDayName.text = dayName

        let forecastBox: UIStackView = {
            let forecastBox = UIStackView()
            forecastBox.axis = .vertical
            forecastBox.distribution = .fillEqually
            return forecastBox
        }()
        let forecastIcon: UIImageView = {
            let forecastIcon = UIImageView()
            forecastIcon.image = UIImage(named: image)
            forecastIcon.contentMode = .scaleAspectFit
            return forecastIcon
        }()
        let forecastTemp: UILabel = {
            let forecastTemp = UILabel()
            forecastTemp.text = "\(temp)°"
            return forecastTemp
        }()

        forecastBox.addArrangedSubview(forecastIcon)
        forecastBox.addArrangedSubview(forecastTemp)
        forecastContainer.addArrangedSubview(forecastBox)
    }
}
