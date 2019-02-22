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
    @IBOutlet weak var weatherInfoStackView: UIStackView!

    var initialHeight: CGFloat!
    var minHeight: CGFloat!

    convenience init(minHeight: CGFloat) {
        self.init(frame: .zero)
        self.minHeight = minHeight
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControls()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControls()
    }

    override func layoutSubviews() {
        if self.initialHeight == nil {
            initialHeight = self.frame.height
        }

        let alpha = (self.frame.height - minHeight) / (initialHeight - minHeight)
        weatherInfoStackView.alpha = alpha
    }

    func setupControls() {
        Bundle.main.loadNibNamed("WeatherHeaderView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.autoPinEdgesToSuperviewEdges()
    }

    func updateData(cityname: String, description: String, image: String, temp: Int, humidity: Int, windSpeed: Int, windDirection: String) {
        cityNameLabel.text = "\(cityname)\n\(description)"
        weatherIcon.image = UIImage(named: image)!
        tempLabel.text = "\(temp)°"
        humidityLabel.text = "\(humidity)%"
        windSpeedLabel.text = "\(windSpeed) Km/h"
        windDirectionLabel.text = "\(windDirection)"
    }
}
