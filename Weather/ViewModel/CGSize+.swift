//
//  CGSize+.swift
//  Weather
//
//  Created by Anton Tolstov on 23.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

extension CGSize {
    init(same widthAndHight: CGFloat) {
        self.init(width: widthAndHight, height: widthAndHight)
    }
}
