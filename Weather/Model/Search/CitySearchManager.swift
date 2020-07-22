//
//  CitySearchManager.swift
//  Weather
//
//  Created by Anton Tolstov on 22.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

final class CitySearchManager {
    
    private let allCities: [City]
    
    // MARK: - Public properties
    
    @Lowercased var filter: String? {
        didSet {
            filterCities()
        }
    }
    
    private(set) var cities = [City]()
    
    // MARK: - Initializers
    
    init(with loader: CityLoader) {
        allCities = (try? loader.load()) ?? []
        cities = allCities
    }
    
    // MARK: - Filtering
    
    private func filterCities() {
        guard let filter = filter else {
            cities = allCities
            return
        }
        
        cities = allCities.filter {
            $0.name.lowercased().contains(filter) || $0.country.lowercased().contains(filter)
        }.sorted {
            let firstName = $0.name.lowercased()
            let secondName = $1.name.lowercased()
            let firstCountry = $0.country.lowercased()
            let secondCountry = $1.country.lowercased()
            
            return firstName.contains(filter) && secondName.contains(filter) ?
                // If both city names contains filter, sort by first occurrence
                firstName.firstIndex(of: filter)! < secondName.firstIndex(of: filter)!
                // If only one city name contains filter, it goes first
                : firstName.contains(filter) ? true
                : secondName.contains(filter) ? true
                    // If only countries contains filter, sort by first occurrence
                : firstCountry.firstIndex(of: filter)! < secondCountry.firstIndex(of: filter)!
        }
    }
}

