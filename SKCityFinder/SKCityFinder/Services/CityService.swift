//
//  CityService.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import Foundation

typealias CitiesCallBack = ([City]) -> Void

class CityService {
    func getCities(_ callBack:@escaping CitiesCallBack) {
        guard let mainUrl = Bundle.main.url(forResource: "cities", withExtension: "json") else { return }
        var cities = decodeData(pathName: mainUrl)
        cities.sort(by: { $0.name < $1.name })
        callBack(cities)
    }
    
    func decodeData(pathName: URL) -> [City] {
        do {
            let jsonData = try Data(contentsOf: pathName)
            let decoder = JSONDecoder()
            return try decoder.decode([City].self, from: jsonData)
        } catch {
            return []
        }
    }
}
