//
//  CityViewController.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 21/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var cityTableView: UITableView!

    let KCityCellId = "cityTableCell"
    let KForecastClass = "CityTableViewCell"

    var originalCityData: [CityData] = []
    var filteredCityData: [CityData] = []
    var selectedItems: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrols()
    }

    func setupConstrols() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CityViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        let forecastCellNib = UINib(nibName: KForecastClass, bundle: Bundle(for: CityViewController.self))
        cityTableView.register(forecastCellNib, forCellReuseIdentifier: KCityCellId)
        cityTableView.dataSource = self
        cityTableView.delegate = self
        citySearchBar.delegate = self

        getCityList()
    }

    func getCityList() {
        CityModel.sharedInstance.getCityList(responseHandler: { (cityData) in
            self.originalCityData = cityData
            self.filteredCityData = cityData
        }) { (error) in
            print(error as Any)
        }
    }

    func showSelectionAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func saveCitySelection(_ sender: Any) {
        if selectedItems.count > 0 {
            if selectedItems.count <= 5 {
                CityModel.sharedInstance.saveSelectedCities(cities: selectedItems)
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            } else {
                showSelectionAlert(message: "No puedes seleccionar más de 5 ciudades")
            }
        } else {
            showSelectionAlert(message: "Por favor selecciones una ciudad")
        }
    }

    @objc func dismissKeyboard() {
        citySearchBar.resignFirstResponder()
    }
}

extension CityViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCityData.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cityTableView.dequeueReusableCell(withIdentifier: KCityCellId, for: indexPath)

        if let cityCell = cell as? CityTableViewCell {
            cityCell.updateCellData(cityName: filteredCityData[indexPath.item].name, id: filteredCityData[indexPath.item].id)

            if selectedItems.contains(cityCell.cityId) {
                cityCell.selectionStyle = .gray
                cityCell.accessoryType = .checkmark
            } else {
                cityCell.accessoryType = .none
            }

            return cityCell
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        if let cityCell = tableView.cellForRow(at: indexPath) as? CityTableViewCell {
            selectedItems.append(cityCell.cityId)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none

        if let cityCell = tableView.cellForRow(at: indexPath) as? CityTableViewCell {
            if selectedItems.contains(cityCell.cityId) {
                selectedItems = selectedItems.filter { $0 != cityCell.cityId }
            }
        }
    }
}

extension CityViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.filteredCityData = self.originalCityData.filter { (cityData) -> Bool in
                cityData.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            self.filteredCityData = self.originalCityData
        }

        self.cityTableView.reloadData()
    }
}
