//
//  ForecastCollectionViewCellTest.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 22/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class ForecastCollectionViewCellTest: UICollectionViewCell {

    @IBOutlet weak var forecastDayName: UILabel!
    @IBOutlet weak var forecastStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func appendForecast(forecast: [ForecastDataResult]) {
        if forecastStackView.subviews.count == 0 {
            for hourForecast in forecast {

                forecastDayName.text = hourForecast.date

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
                    return hourForecastDate
                }()
                let hourForecastImageView: UIImageView = {
                    let hourForecastImageView = UIImageView()
                    hourForecastImageView.image = UIImage(named: hourForecast.icon)
                    hourForecastImageView.contentMode = .scaleAspectFit
                    return hourForecastImageView
                }()
                let hourForecastTemp: UILabel = {
                    let hourForecastTemp = UILabel()
                    hourForecastTemp.text = hourForecast.temp
                    hourForecastTemp.textAlignment = .center
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
