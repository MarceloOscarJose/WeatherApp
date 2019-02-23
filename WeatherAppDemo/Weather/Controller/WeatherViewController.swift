//
//  WeatherViewController.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import PXStickyHeaderCollectionView
import PureLayout

class WeatherViewController: UIViewController {

    let KForecastCellId = "ForecastCellTest"
    let KForecastClass = "ForecastCollectionViewCellTest"

    // UI Vars
    let forecastCellPadding: CGFloat = 10.0
    let initialHeaderHeight: CGFloat = 300
    let minHeaderHeight: CGFloat = 180

    let mainModel = MainModel()

    var containerView: PXStickyHeaderCollectionView!
    let containerHeader: WeatherHeaderView = WeatherHeaderView()

    var forecastData: ForecastData!

    var cityId: Int = 0

    convenience init(cityId: Int) {
        self.init()
        self.cityId = cityId
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.forecastData == nil {
            getWeatherData()
        }
    }

    func setupControls() {

        self.view.backgroundColor = UIColor.primaryColor
        containerView = PXStickyHeaderCollectionView(initHeaderHeight: initialHeaderHeight, minHeaderHeight: minHeaderHeight, headerView: containerHeader)
        self.view.addSubview(containerView)
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0))

        let forecastCellNib = UINib(nibName: KForecastClass, bundle: Bundle.main)
        containerView.collectionView.register(forecastCellNib, forCellWithReuseIdentifier: KForecastCellId)
        containerView.collectionView.backgroundColor = UIColor.shadowColor

        containerView.delegate = self
        containerView.dataSource = self
    }

    func getWeatherData() {

        mainModel.getWeather(id: cityId, responseHandler: { (mainData) in
            self.containerHeader.updateData(cityname: mainData.weather.name, description: mainData.weather.mainDescription, image: mainData.weather.icon, temp: mainData.weather.temp, humidity: mainData.weather.humidity, windSpeed: mainData.weather.windSpeed, windDirection: mainData.weather.windDirection)
            self.forecastData = mainData.forecast
            self.containerView.collectionView.reloadData()
        }) { (error) in
            print(error as Any)
        }
    }
}
