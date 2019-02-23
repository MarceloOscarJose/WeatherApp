//
//  WeatherViewController+Delegate.swift
//  WeatherAppDemo
//
//  Created by Marcelo Oscar José on 2/20/19.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return forecastData != nil ? self.forecastData.list.count : 0
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastData != nil ? 1 : 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KForecastCellId, for: indexPath) as! ForecastCollectionViewCellTest
        if self.forecastData != nil {
            let listData = self.forecastData.list[indexPath.section]
            cell.appendForecast(forecast: listData)
            //cell.updateCellData(image: listData.icon, temp: listData.temp, date: listData.date, dayName: listData.dayName)
        }
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem: CGFloat = (self.view.frame.width - 20)
        return CGSize(width: forecastData != nil ? widthPerItem : self.view.frame.width, height: 130)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: forecastCellPadding, left: forecastCellPadding, bottom: 0, right: forecastCellPadding)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        /*if indexPath.row == self.moviesData.count - 1 {
         self.nextPage = true
         self.getMovies()
         }*/
    }
}
