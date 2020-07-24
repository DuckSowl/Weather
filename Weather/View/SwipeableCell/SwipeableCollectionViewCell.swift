//
//  SwipeableCollectionViewCell.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit
import Pin

class SwipeableCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    let swipableContentView = UIView()
    let deletionContentView = UIView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        addSubview(scrollView)
        scrollView.pin.all().activate
        return scrollView
    }()
    
    weak var delegate: SwipeableCollectionViewCellDelegate?
    
    var isDeletionEnabled: Bool {
        set { scrollView.isScrollEnabled = newValue }
        get { scrollView.isScrollEnabled }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View configuration
    
    private func setupSubviews() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(swipableContentView)
        stackView.addArrangedSubview(deletionContentView)
        
        scrollView.addSubview(stackView)
        stackView.pin.all().activate
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2)
        ])
    }
}

// MARK: - UIScrollViewDelegate

extension SwipeableCollectionViewCell: UIScrollViewDelegate  {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= scrollView.frame.width {
            delegate?.didSwipeToDelete(cell: self)
            scrollView.setContentOffset(.zero, animated: false)
        }
    }
}
