//
//  CityModel.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 20/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit
import CoreData

class CityModel: NSObject {

    static let sharedInstance = CityModel()

    let userDefaults = UserDefaults.standard
    let preloadCityDataKey = "didPreloadCityData"
    let selectedCitiesKey = "selectedCities"

    public func getCityList(responseHandler: @escaping (_ response: [CityData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        if self.shouldPreloadData() {
            if let cityData = getCityListFromFile() {
                preloadCityData(cityData: cityData)
                responseHandler(cityData)
            } else {
                errorHandler(nil)
            }
        } else {
            fetchCityList(responseHandler: responseHandler, errorHandler: errorHandler)
        }
    }

    private func fetchCityList(responseHandler: @escaping (_ response: [CityData]) -> Void, errorHandler: @escaping (_ error: Error?) -> Void) {
        CoreDataManager.sharedInstance.persistentContainer.viewContext.performAndWait {
            do {
                let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
                let cityData = try fetchRequest.execute()
                
                var cityResponse: [CityData] = []
                for city in cityData {
                    cityResponse.append(CityData(id: Int(city.id), name: city.name!))
                }
                
                responseHandler(cityResponse)
            } catch {
                errorHandler(error)
            }
        }
    }

    public func getSelectedCities() -> [Int] {
        return userDefaults.array(forKey: selectedCitiesKey) as! [Int]
    }

    public func saveSelectedCities(cities: [Int]) {
        userDefaults.setValue(cities, forKey: selectedCitiesKey)
    }

    public func removeSelectedCities() {
        userDefaults.removeObject(forKey: selectedCitiesKey)
    }

    public func shouldSelectCities() -> Bool {
        if let cities = userDefaults.array(forKey: selectedCitiesKey), cities.count > 0 {
            return false
        }

        return true
    }

    private func shouldPreloadData() -> Bool {
        return !userDefaults.bool(forKey: preloadCityDataKey)
    }

    public func preloadCityData(cityData: [CityData]) {
        let backgroundContext = CoreDataManager.sharedInstance.persistentContainer.newBackgroundContext()
        CoreDataManager.sharedInstance.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

        backgroundContext.perform {
            do {
                for city in cityData {
                    let cityEntity = City(context: backgroundContext)
                    cityEntity.id = Int32(city.id)
                    cityEntity.name = city.name
                    cityEntity.didSave()
                }

                try backgroundContext.save()
                self.userDefaults.set(true, forKey: self.preloadCityDataKey)
            } catch {
                print(error)
            }
        }
    }

    private func getCityListFromFile() -> [CityData]? {
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let cityResult = try JSONDecoder().decode([CityData].self, from: data)
                return cityResult.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
            } catch {
                return nil
            }
        }

        return nil
    }
}
