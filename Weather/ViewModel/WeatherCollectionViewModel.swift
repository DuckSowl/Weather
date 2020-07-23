//
//  WeatherCollectionViewModel.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

class WeatherCollectionViewModel {
    weak var delegate: UpdateDelegate?
    
    private var _weatherList: [Weather]
    
    init(weatherList: [Weather]) {
        _weatherList = weatherList
    }
    
    var weatherList: [WeatherViewModel] {
        _weatherList.map { WeatherViewModel(weather: $0) }
    }
    
    func remove(at index: Int) {
        _weatherList.remove(at: index)
        update()
    }
    
    func add(weather: Weather) {
        _weatherList.append(weather)
        update()
    }
    
    private func update() {
        delegate?.didUpdate()
    }
}
