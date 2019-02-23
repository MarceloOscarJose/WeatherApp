//
//  WeatherHeaderView.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/22/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PureLayout

class WeatherHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var weatherInfoView: UIStackView!
    
    var initialHeight: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        if self.initialHeight == nil {
            initialHeight = self.frame.height
            setupControls()
        }

        let topMargen = initialHeight - 100
        let alpha = (self.frame.height - topMargen) / (initialHeight - topMargen)
        weatherInfoView.alpha = alpha
    }

    func setupControls() {
        Bundle.main.loadNibNamed("WeatherHeaderView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }

    func updateData(cityname: String, description: String, image: String, temp: String, humidity: String, windSpeed: String, windDirection: String) {
        cityNameLabel.text = "\(cityname)\n\(description)"
        weatherIcon.image = UIImage(named: image)!
        tempLabel.text = temp
        humidityLabel.text = humidity
        windSpeedLabel.text = windSpeed
        windDirectionLabel.text = windDirection
    }
}
