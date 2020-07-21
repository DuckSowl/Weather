//
//  WeatherCollectionViewModel.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

struct WeatherCollectionViewModel {
    private let _weatherList: [Weather]
    
    init(weatherList: [Weather]) {
        _weatherList = weatherList
    }
    
    var weatherList: [WeatherViewModel] {
        _weatherList.map { WeatherViewModel(weather: $0) }
    }
}
