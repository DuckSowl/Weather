//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

struct WeatherViewModel {
    private let weather: Weather
    
    init(weather: Weather, style: WeatherCollectionStyle,
         delegate: SwipeableCollectionViewCellDelegate?) {
        self.weather = weather
        self.style = style
        self.delegate = delegate
    }
    
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
        case .snow:             return UIColor(hex: 0xD5DBE3)
        case .clear:            return UIColor(hex: 0xF7C479)
        case .atmosphere:       return UIColor(hex: 0xB4C3D9)
        }
    }
    
    var style: WeatherCollectionStyle
    weak var delegate: SwipeableCollectionViewCellDelegate?
    
    static let deletionColor = UIColor(hex: 0xDD3946)
    static let deletionImage = UIImage(systemName: "trash")
    static let deletionImageColor = UIColor.white
    static let deletionImageSize = CGSize(same: 40)
}
