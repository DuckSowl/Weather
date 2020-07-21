//
//  WeatherViewController.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {

    private var weatherCollectionController = WeatherCollectionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        // Data Example
        weatherCollectionController.viewModel =
            WeatherCollectionViewModel(weatherList:
                [Weather(city: "Moscow", temperature: 13, condition: .clouds),
                 Weather(city: "London", temperature: 22, condition: .rain),
                 Weather(city: "Paris",  temperature: 26, condition: .clear)
            ])
                
        addChild(weatherCollectionController)
        view.addSubview(weatherCollectionController.view)
        didMove(toParent: self)
                
        let changeStyleButton = UIButton()
        changeStyleButton.setTitle("Change Style", for: .normal)
        view.addSubview(changeStyleButton)
        changeStyleButton.pin.sides().bottomSafe().activate
        changeStyleButton.addTarget(self, action: #selector(table),
                                    for: .touchUpInside)
        
        weatherCollectionController.view.pin
            .top().sides().above(changeStyleButton).activate
    }
    
    @objc private func table() {
        weatherCollectionController.style =
            weatherCollectionController.style == .pages ? .rows : .pages
    }
}
