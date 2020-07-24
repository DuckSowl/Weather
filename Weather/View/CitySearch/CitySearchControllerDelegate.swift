//
//  CitySearchControllerDelegate.swift
//  Weather
//
//  Created by Anton Tolstov on 23.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

protocol CitySearchControllerDelegate: AnyObject {
    func didSelect(city: City)
}
