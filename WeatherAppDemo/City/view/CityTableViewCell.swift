//
//  CityTableViewCell.swift
//  WeatherAppDemo
//
//  Created by Marcelo José on 21/02/2019.
//  Copyright © 2019 Marcelo Oscar José. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    var cityId: Int!
    @IBOutlet weak var cityNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCellData(cityName: String, id: Int) {
        cityNameLabel.text = cityName
        cityId = id
    }
}
