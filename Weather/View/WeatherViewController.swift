//
//  WeatherViewController.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import CoreLocation

final class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    private lazy var weatherCollectionController: WeatherCollectionController = {
        return WeatherCollectionController(with: weatherCollectionViewModel)
    }()
    
    private lazy var collectionStyleButton: UIButton = {
        let collectionStyleButton = UIButton()
        let image = UIImage(systemName: "equal",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50,
                                                                           weight: .regular))
        collectionStyleButton.setImage(image, for: .normal)
        view.addSubview(collectionStyleButton)
        collectionStyleButton.addTarget(self, action: #selector(table),
                                        for: .touchUpInside)
        
        collectionStyleButton.tintColor = .white
        
        view.addSubview(collectionStyleButton)
        collectionStyleButton.pin.right(30).bottomSafe(20).activate
        return collectionStyleButton
    }()
    
    private lazy var addNewCityButton: UIButton = {
        let collectionStyleButton = UIButton()
        let image = UIImage(systemName: "plus",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 40,
                                                                           weight: .medium))
        collectionStyleButton.setImage(image, for: .normal)
        view.addSubview(collectionStyleButton)
        collectionStyleButton.addTarget(self, action: #selector(addNewCity),
                                        for: .touchUpInside)
        
        collectionStyleButton.tintColor = .white
        
        view.addSubview(collectionStyleButton)
        collectionStyleButton.pin.left(30).bottomSafe(20).activate
        return collectionStyleButton
    }()
    
    var weatherCollectionViewModel = WeatherCollectionViewModel(weatherList:
        [Weather(city: "Moscow", temperature: 13, condition: .clouds),
         Weather(city: "London", temperature: 22, condition: .rain),
         Weather(city: "Paris",  temperature: 26, condition: .clear)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        addChild(weatherCollectionController)
        view.addSubview(weatherCollectionController.view)
        didMove(toParent: self)
                
        _ = collectionStyleButton
        _ = addNewCityButton
        
        view.backgroundColor = UIColor(hex: 0xF0F0F0)
        weatherCollectionController.view.pin.all().activate
    }
    
    @objc private func addNewCity() {
        weatherCollectionViewModel.add(weather: Weather(city: "New Orlean",
                                                        temperature: -273,
                                                        condition: .thunderstorm))
    }
    
 
    @objc private func table() {
        // TODO: - Move to collection view
        if weatherCollectionController.style == .pages {
            weatherCollectionController.style = .rows
            collectionStyleButton.tintColor = .black
        } else {
             weatherCollectionController.style = .pages
            collectionStyleButton.tintColor = .white
        }
    }
}
