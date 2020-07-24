//
//  WeatherCellView.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Pin
import UIKit

final class WeatherCellView: SwipeableCollectionViewCell {
    
    // MARK: - Cell configuration properties
        
    var viewModel: WeatherViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            cityLabel.text = viewModel.city
            temperatureLabel.text = viewModel.temperature
            conditionLabel.text = viewModel.condition
            backgroundColor = viewModel.color
        }
    }
    
    var style: WeatherCollectionStyle = .pages {
        didSet {
            configureConstraints()
            configureFonts()
            configureDeletion()
        }
    }
    
    // MARK: - Subviews
    
    private lazy var cityLabel = label
    private lazy var temperatureLabel = label
    private lazy var conditionLabel = label
    
    private var label: UILabel {
        let label = UILabel()
        label.textColor = .white
        swipableContentView.addSubview(label)
        return label
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDeletionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    
    private func configureConstraints() {
        switch style {
        case .pages:
            cityLabel.pin.unpin().hCenter().activate
            
            conditionLabel.pin.unpin().hCenter().activate
            
            temperatureLabel.pin.unpin()
                // TODO: - Find normal centering solution
                .hCenter(13).vCenter()
                .below(cityLabel).above(conditionLabel)
                .activate
            
        case .rows:
            cityLabel.pin.unpin().top(20).left(20).activate
            
            conditionLabel.pin.unpin().bottom(20).left(20)
                .below(cityLabel)
                .activate
            
            temperatureLabel.pin.unpin()
                .after(cityLabel, be: .greater)
                .vCenter().right(20)
                .activate
        }
    }
    
    private func configureFonts() {
        switch style {
        case .pages:
            [cityLabel, conditionLabel].forEach {
                $0.font = .preferredFont(forTextStyle: .title1)
            }
            temperatureLabel.font = .boldSystemFont(ofSize: 80)
        case .rows:
            [cityLabel, conditionLabel].forEach {
                $0.font = .preferredFont(forTextStyle: .title2)
            }
            temperatureLabel.font = .preferredFont(forTextStyle: .title1)
        }
    }
    
    private func configureDeletion() {
        isDeletionEnabled = style == .rows
    }
    
    private func setupDeletionView() {
        deletionContentView.backgroundColor = WeatherViewModel.deletionColor
        let deletionImage = UIImageView(image: WeatherViewModel.deletionImage)
        deletionImage.tintColor = WeatherViewModel.deletionImageColor
        deletionContentView.addSubview(deletionImage)
        
        deletionImage.pin.left(20).vCenter()
            .size(WeatherViewModel.deletionImageSize).activate
    }
}
