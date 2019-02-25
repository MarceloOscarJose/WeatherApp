//
//  ForecastCollectionViewCell.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 22/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var forecastDayName: UILabel!
    @IBOutlet weak var forecastStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCellData(data: [(icon: String, temp: String, date: String, hour: String, dayName: String)]) {
        if forecastStackView.subviews.count == 0 {
            for hourForecast in data {

                forecastDayName.text = "\(hourForecast.dayName) - \(hourForecast.date)"

                let hourForecastStackView: UIStackView = {
                    let hourForecastStackView = UIStackView()
                    hourForecastStackView.axis = .vertical
                    hourForecastStackView.distribution = .fillEqually
                    hourForecastStackView.contentMode = .scaleToFill
                    return hourForecastStackView
                }()
                let hourForecastDate: UILabel = {
                    let hourForecastDate = UILabel()
                    hourForecastDate.text = hourForecast.hour
                    hourForecastDate.textAlignment = .center
                    hourForecastDate.font = UIFont.systemFont(ofSize: 13, weight: .light)
                    return hourForecastDate
                }()
                let hourForecastImageView: UIImageView = {
                    let hourForecastImageView = UIImageView()
                    hourForecastImageView.image = UIImage(named: hourForecast.icon)
                    hourForecastImageView.contentMode = .scaleAspectFit
                    hourForecastImageView.clipsToBounds = true
                    return hourForecastImageView
                }()
                let hourForecastTemp: UILabel = {
                    let hourForecastTemp = UILabel()
                    hourForecastTemp.text = hourForecast.temp
                    hourForecastTemp.textAlignment = .center
                    hourForecastTemp.font = UIFont.systemFont(ofSize: 13, weight: .light)
                    return hourForecastTemp
                }()

                forecastStackView.addArrangedSubview(hourForecastStackView)
                hourForecastStackView.addArrangedSubview(hourForecastDate)
                hourForecastStackView.addArrangedSubview(hourForecastImageView)
                hourForecastStackView.addArrangedSubview(hourForecastTemp)
            }
        }
    }
}
