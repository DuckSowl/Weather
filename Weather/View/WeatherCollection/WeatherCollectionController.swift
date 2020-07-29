//
//  WeatherCollectionController.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

final class WeatherCollectionController: UIViewController {
    
    // MARK: - Constants
    
    let cellId = "WeatherCellView"
    
    // MARK: - View Model
    
    weak var viewModel: WeatherCollectionViewModel?
    
    // MARK: - Initializers
    
    init(with viewModel: WeatherCollectionViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.viewModel?.updateDelegate = self
        self.viewModel?.cellDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
  
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WeatherCellView.self,
                                forCellWithReuseIdentifier: cellId)
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        view = collectionView
        configureAndReload()
    }
    
    private func configureAndReload() {
        guard let viewModel = viewModel else { return }
        
        switch viewModel.style {
        case .pages:
            layout.scrollDirection = .horizontal
            collectionView.isPagingEnabled = true
            collectionView.alwaysBounceVertical = false
            layout.estimatedItemSize = .zero
        case .rows:
            layout.scrollDirection = .vertical
            collectionView.isPagingEnabled = false
            collectionView.alwaysBounceVertical = true
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource

extension WeatherCollectionController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.weatherList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeatherCellView
        
        cell.viewModel = viewModel?.weatherList[indexPath.row]
            
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
        configureAndReload()
    }
}
