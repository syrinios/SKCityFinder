//
//  City.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import Foundation

struct City: Codable {
    let _id: Int64
    let country: String
    let name: String
    let coord: Coord
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct CityViewData {
    let name: String
    let coord: Coord
}
