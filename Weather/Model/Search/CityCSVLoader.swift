//
//  CityCSVLoader.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import CoreLocation

struct CityCSVLoader {
    
    private let citiesUrl: URL
    
    init(with citiesUrl: URL) {
        self.citiesUrl = citiesUrl
    }
    
    // MARK: - Error
    
    enum LoadingError: Error {
        case dataCorrupted
    }
}

// MARK: - CityLoader

extension CityCSVLoader: CityLoader {
    func load() throws -> [City] {
        try String(contentsOf: citiesUrl)
            .components(separatedBy: "\n")
            .map { $0.components(separatedBy: ";") }
            .map {
                guard $0.count == 4,
                    let latitude = Double($0[2]),
                    let longitude = Double($0[3]) else {
                        throw LoadingError.dataCorrupted
                }
                
                return City(name: $0[0], country: $0[1],
                             location: .init(latitude: latitude,
                                             longitude: longitude))
        }
    }
}

