//
//  CityLoader.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

protocol CityLoader {
    func load() throws -> [City]
}
