//
//  WeatherCollectionController.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

final class WeatherCollectionController: UIViewController {
    
    // MARK: - View configutaion properties
    
    var style: WeatherCollectionStyle = .pages {
        didSet { configureCollectionStyle() }
    }
    
    private weak var viewModel: WeatherCollectionViewModel?
    
    init(with viewModel: WeatherCollectionViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
  
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WeatherCellView.self,
                                forCellWithReuseIdentifier: Constants.cellId)
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = collectionView
        configureCollectionStyle()
    }
    
    private func configureCollectionStyle() {
        switch style {
        case .pages:
            layout.scrollDirection = .horizontal
            collectionView.isPagingEnabled = true
            collectionView.alwaysBounceVertical = false
                        
        case .rows:
            layout.scrollDirection = .vertical
            collectionView.isPagingEnabled = false
            collectionView.alwaysBounceVertical = true
        }
        
        collectionView.reloadData()
    }
    
    private enum Constants {
        static let cellId = "WeatherCellView"

    }
}

// MARK: - UICollectionViewDataSource

extension WeatherCollectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.weatherList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellId, for: indexPath) as! WeatherCellView
        
        cell.style = style
        cell.viewModel = viewModel?.weatherList[indexPath.row]
        cell.delegate = self
            
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

// MARK: - SwipeableCollectionViewCellDelegate

extension WeatherCollectionController: SwipeableCollectionViewCellDelegate {
    func didSwipeToDelete(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        viewModel?.remove(at: indexPath.row)
    }
}

// MARK: - UpdateDelegate

extension WeatherCollectionController: UpdateDelegate {
    func didUpdate() {
        collectionView.reloadData()
    }
}
