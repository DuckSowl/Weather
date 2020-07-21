//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

struct WeatherViewModel {
    let weather: Weather
    
    var city: String {
        weather.city
    }
    
    var temperature: String {
        "\(weather.temperature)º"
    }
    
    var condition: String {
        switch weather.condition {
        case .thunderstorm: return "Thunderstorm"
        case .drizzle:      return "Drizzle"
        case .rain:         return "Rain"
        case .snow:         return "Snow"
        case .clear:        return "Clear"
        case .clouds:       return "Clouds"
        case .atmosphere(let description):
            return description
        }
    }
    
    var color: UIColor {
        switch weather.condition {
        case .thunderstorm:     return UIColor(hex: 0x374D72)
        case .drizzle, .clouds: return UIColor(hex: 0x54ADCF)
        case .rain:             return UIColor(hex: 0x5A84A7)
        case .snow:             return UIColor(hex: 0xd5dbe3)
        case .clear:            return UIColor(hex: 0xF7C479)
        case .atmosphere:       return UIColor(hex: 0xB4C3D9)
        }
    }
}
