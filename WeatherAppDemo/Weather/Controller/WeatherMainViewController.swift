//
//  WeatherMainViewController.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 19/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class WeatherMainViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let cities: [Int] = CityModel.sharedInstance.getSelectedCities()

    var pages = [UIViewController]()
    let pageControl = UIPageControl()

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
        self.view.backgroundColor = UIColor.primaryColor

        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = 0
        self.pageControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.view.addSubview(self.pageControl)

        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
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
