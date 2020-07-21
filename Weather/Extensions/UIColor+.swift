//
//  UIColor+.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let scale: (Int) -> CGFloat = { CGFloat($0) / 255 }
        let red   = scale((hex >> 16) & 0xFF)
        let green = scale((hex >> 8)  & 0xFF)
        let blue  = scale( hex        & 0xFF)
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
