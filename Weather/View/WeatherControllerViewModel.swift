//
//  WeatherControllerViewModel.swift
//  Weather
//
//  Created by Anton Tolstov on 24.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

struct WeatherControllerViewModel {
    // MARK: - Collection View Model
    var weatherCollectionViewModel = WeatherCollectionViewModel(weatherList:
        [Weather(city: "Moscow", temperature: 13, condition: .clouds),
         Weather(city: "London", temperature: 22, condition: .rain),
         Weather(city: "Paris",  temperature: 26, condition: .clear)
    ])
    
    // MARK: - Colors
    static let tintColor = UIColor.white
    static let headerFooterColor = UIColor(hex: 0x6D6875)
    static let backgroundColor = UIColor(hex: 0xF0F0F0)
    
    // MARK: - Button Images
    static let newCityButtonImage = UIImage(systemName: "plus",
                                            withConfiguration: UIImage
                                                .SymbolConfiguration(pointSize: 40))!
    static let styleButtonImage = UIImage(systemName: "equal",
                                          withConfiguration: UIImage
                                            .SymbolConfiguration(pointSize: 40))!
    
    // MARK: - Other
    static let weatherLabel = "Weather"
}
