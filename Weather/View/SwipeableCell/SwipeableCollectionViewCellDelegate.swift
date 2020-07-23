//
//  SwipeableCollectionViewCellDelegate.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

protocol SwipeableCollectionViewCellDelegate: AnyObject {
    func didSwipeToDelete(cell: UICollectionViewCell)
}
