//
//  Weather.swift
//  Weather
//
//  Created by Anton Tolstov on 21.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import Foundation

struct Weather {
    
    let city: String
    let temperature: Int
    let condition: Condition
    
    enum Condition {
        case thunderstorm
        case drizzle
        case rain
        case snow
        case atmosphere(description: String)
        case clear
        case clouds
    }
}
