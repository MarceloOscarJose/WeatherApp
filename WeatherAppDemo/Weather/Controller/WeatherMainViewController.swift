//
//  WeatherMainViewController.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 19/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import PureLayout

class WeatherMainViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let cities: [Int] = CityModel.sharedInstance.getSelectedCities()
    var pages = [UIViewController]()
    var weatherDelegate: WeatherMainViewControllerProtocol?

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPage = 0
        pageControl.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return pageControl
    }()
    let cityButton: UIButton = {
        let cityButton = UIButton()
        cityButton.setImage(UIImage(named: "city"), for: .normal)
        return cityButton
    }()
    let reloadButton: UIButton = {
        let reloadButton = UIButton()
        reloadButton.setImage(UIImage(named: "reload"), for: .normal)
        return reloadButton
    }()
    let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "background")
        return backgroundImage
    }()

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
        setupControls()
    }

    func getCities() {
        for city in self.cities {
            pages.append(WeatherViewController(cityId: city))
        }
    }

    func setupControls() {
        self.dataSource = self
        self.delegate = self
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.autoPinEdgesToSuperviewEdges()
        self.view.backgroundColor = UIColor.clear

        self.weatherDelegate = pages[0] as? WeatherViewController

        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.pageControl.numberOfPages = self.pages.count
        self.view.addSubview(self.pageControl)

        self.pageControl.autoPinEdge(toSuperviewSafeArea: .left, withInset: 10)
        self.pageControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 10)
        self.pageControl.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        self.pageControl.autoSetDimension(.height, toSize: 50)

        pageControl.addSubview(cityButton)
        pageControl.addSubview(reloadButton)

        cityButton.autoAlignAxis(.horizontal, toSameAxisOf: pageControl)
        cityButton.autoPinEdge(.right, to: .right, of: pageControl, withOffset: -15)
        cityButton.autoSetDimensions(to: CGSize(width: 40, height: 40))
        cityButton.addTarget(self, action: #selector(navigateToCityScreen), for: .touchUpInside)

        reloadButton.autoAlignAxis(.horizontal, toSameAxisOf: pageControl)
        reloadButton.autoPinEdge(.left, to: .left, of: pageControl, withOffset: 15)
        reloadButton.autoSetDimensions(to: CGSize(width: 30, height: 30))
        reloadButton.addTarget(self, action: #selector(reloadMainScreen), for: .touchUpInside)
    }

    @objc func navigateToCityScreen() {
        self.navigationController?.pushViewController(CityViewController(), animated: true)
    }

    @objc func reloadMainScreen() {
        if let delegate = self.weatherDelegate {
            delegate.reloadWeather()
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex != 0 {
                self.weatherDelegate = viewController as! WeatherViewController
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                self.weatherDelegate = viewController as! WeatherViewController
                return self.pages[viewControllerIndex + 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}

protocol WeatherMainViewControllerProtocol {
    func reloadWeather()
}
