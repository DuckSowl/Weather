//
//  WeatherViewController.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import Pin
import CoreLocation

final class WeatherViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - View Model
    
    typealias ViewModel = WeatherControllerViewModel
    let viewModel = WeatherControllerViewModel()
    
    // MARK: - Subviews
    
    private lazy var newCityButton: UIButton =
    makeButton(with: ViewModel.newCityButtonImage,
               action: #selector(addNewCity),
               pins: { $0.left(30).bottomSafe(20) })
    
    private lazy var toggleStyleButton: UIButton =
        makeButton(with: ViewModel.styleButtonImage,
                   action: #selector(toggleStyle),
                   pins: { $0.right(30).bottomSafe(20) })
            
    private lazy var weatherCollectionController: WeatherCollectionController = {
        let weatherCollectionController = WeatherCollectionController(with: viewModel.weatherCollectionViewModel)
        addChild(weatherCollectionController)
        view.addSubview(weatherCollectionController.view)
        didMove(toParent: self)
        return weatherCollectionController
    }()
    
    private lazy var footerView = makeHeaderFooterView()
    
    private lazy var headerView: UIView = {
        let headerView = makeHeaderFooterView()
        
        let weatherLabel = UILabel()
        weatherLabel.text = ViewModel.weatherLabel
        weatherLabel.textColor = ViewModel.tintColor
        weatherLabel.font = .preferredFont(forTextStyle: .title1)
        
        headerView.addSubview(weatherLabel)
        weatherLabel.pin.left(20).bottom(20).activate
        
        return headerView
    }()

    // MARK: - View Life Cycle
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = ViewModel.backgroundColor
        
        configureConstraints()
        
        // Add lazy buttons to view
        _ = toggleStyleButton
        _ = newCityButton
    }
    
    // MARK: - View Configuration
    
    private func configureConstraints() {
        if weatherCollectionController.style == .pages {
            headerView.pin.unpin().activate
            footerView.pin.unpin().activate
            weatherCollectionController.view.pin.unpin().all().activate
        } else {
            headerView.pin.sides().height(100).top().activate
            footerView.pin.sides().height(110).bottom().activate
            weatherCollectionController.view.pin.unpin()
                .below(headerView).above(footerView)
                .sides().activate
        }
    }
    
    private var footerHeaderIsHidden: Bool = true {
        didSet {
            [headerView, footerView].forEach { $0.isHidden = footerHeaderIsHidden }
        }
    }
    
    // MARK: - Actions
    
    @objc private func addNewCity() {
        let citySearchController = CitySearchController()
        present(citySearchController, animated: true)
        
        citySearchController.delegate = self
    }
    
    @objc private func toggleStyle() {
        if weatherCollectionController.style == .pages {
            weatherCollectionController.style = .rows
            footerHeaderIsHidden = false
        } else {
            weatherCollectionController.style = .pages
            footerHeaderIsHidden = true
        }
        configureConstraints()
    }
    
    // MARK: - View Creation
    
    private func makeButton(with image: UIImage, action: Selector,
                            pins: ((Pin) -> (Pin))) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = ViewModel.tintColor
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        view.addSubview(button)
        pins(button.pin).activate
        return button
    }
    
    private func makeHeaderFooterView() -> UIView {
        let subview = UIView()
        subview.backgroundColor = ViewModel.headerFooterColor
        view.addSubview(subview)
        return subview
    }
}

extension WeatherViewController: CitySearchControllerDelegate {
    func didSelect(city: City) {
        // Example weather addition
        let someConditions = [Weather.Condition.clear, .drizzle, .snow, .thunderstorm]
        viewModel
            .weatherCollectionViewModel
            .add(weather: Weather(city: city.name,
                                  temperature: Int.random(in: -30...30),
                                  condition: someConditions.randomElement()!))
    }
}
