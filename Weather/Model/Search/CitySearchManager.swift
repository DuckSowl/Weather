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
        filterCities()
    }
    
    // MARK: - Filtering
    
    private func filterCities() {
        var filteredCities = allCities
        
        if let filter = filter {
            filteredCities = allCities.filter {
                $0.name.lowercased().contains(filter) || $0.country.lowercased().contains(filter)
            }.sorted {
                let firstName = $0.name.lowercased()
                let secondName = $1.name.lowercased()
                let firstCountry = $0.country.lowercased()
                let secondCountry = $1.country.lowercased()
                
                return
                    // If both city names contains filter
                    firstName.contains(filter) && secondName.contains(filter)
                        // and filter occures in firstName earlier
                        ? firstName.firstIndex(of: filter)! < secondName.firstIndex(of: filter)!
                            // first
                            ? true
                        // else if both occurences are the same
                        : firstName.firstIndex(of: filter)! == secondName.firstIndex(of: filter)!
                            // then sort by city name
                            ? firstName < secondName
                        // second
                        : false
                            
                    // else if both countries contains filter
                    : firstCountry.contains(filter) && secondCountry.contains(filter)
                        // and filter occures in firstCountry earlier
                        ? firstCountry.firstIndex(of: filter)! < secondCountry.firstIndex(of: filter)!
                            // first
                            ? true
                        // else if both occurences are the same
                        : firstCountry.firstIndex(of: filter)! == secondCountry.firstIndex(of: filter)!
                            // then sort by country name
                            ? firstCountry < secondCountry
                        // second country name occures later
                        : false
                    // if nothing else only one city name contains filter
                    : firstName.contains(filter)
            }
        }
        
        #if DEBUG
        // With all cities UI tests just freeze
        filteredCities = Array(filteredCities.prefix(10))
        #endif
        
        cities = filteredCities
    }
}

