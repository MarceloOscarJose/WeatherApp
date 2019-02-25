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
    let pageControl = UIPageControl()

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

        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = 0
        self.pageControl.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.view.addSubview(self.pageControl)

        self.pageControl.autoPinEdge(toSuperviewSafeArea: .left, withInset: 10)
        self.pageControl.autoPinEdge(toSuperviewSafeArea: .right, withInset: 10)
        self.pageControl.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10)
        self.pageControl.autoSetDimension(.height, toSize: 50)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex != 0 {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
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
