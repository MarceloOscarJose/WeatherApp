//
//  WeatherViewController.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import PXStickyHeaderCollectionView
import PureLayout

class WeatherViewController: UIViewController, WeatherMainViewControllerProtocol {

    let KForecastCellId = "ForecastCellTest"
    let KForecastClass = "ForecastCollectionViewCell"

    // UI Vars
    let forecastCellHeight: CGFloat = 130.0
    let forecastCellPadding: CGFloat = 10.0
    let initialHeaderHeight: CGFloat = 230
    let minHeaderHeight: CGFloat = 150

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
        self.view.backgroundColor = UIColor.clear
        containerView = PXStickyHeaderCollectionView(initHeaderHeight: initialHeaderHeight, minHeaderHeight: minHeaderHeight, headerView: containerHeader)
        self.view.addSubview(containerView)
        containerView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        containerView.autoPinEdge(.left, to: .left, of: self.view)
        containerView.autoPinEdge(.right, to: .right, of: self.view)
        containerView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 70)

        let forecastCellNib = UINib(nibName: KForecastClass, bundle: Bundle.main)
        containerView.collectionView.register(forecastCellNib, forCellWithReuseIdentifier: KForecastCellId)
        containerView.collectionView.backgroundColor = UIColor.clear

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

    func reloadWeather() {
        self.forecastData = nil
        containerView.collectionView.reloadData()
        getWeatherData()
    }
}
