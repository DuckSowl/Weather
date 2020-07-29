//
//  WeatherCollectionViewModel.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

class WeatherCollectionViewModel {
    
    private var _weatherList: [Weather]
    
    var style: WeatherCollectionStyle {
        didSet { update() }
    }

    weak var updateDelegate: UpdateDelegate?
    weak var cellDelegate: SwipeableCollectionViewCellDelegate?
        
    init(weatherList: [Weather], style: WeatherCollectionStyle) {
        _weatherList = weatherList
        self.style = style
    }
    
    var weatherList: [WeatherViewModel] {
        _weatherList.map {
            WeatherViewModel(weather: $0, style: style, delegate: cellDelegate)
        }
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
        updateDelegate?.didUpdate()
    }
}
