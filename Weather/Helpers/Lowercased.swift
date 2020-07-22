//
//  Lowercased.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

@propertyWrapper struct Lowercased {
    var wrappedValue: String? {
        didSet { wrappedValue = wrappedValue?.lowercased() }
    }

    init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue?.lowercased()
    }
}
