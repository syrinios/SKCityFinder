//
//  CityPresenter.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import Foundation

struct CityViewData{
    let name: String
    let coord: Coord
}

protocol CityView: NSObjectProtocol {
    func reload()
}

protocol CityCell: class {
    func show(city: CityViewData)
}

class CityPresenter {
    fileprivate let cityService: CityService
    weak fileprivate var cityView : CityView?
    private var allCities = [CityViewData]()
    
    var cityCount: Int {
        return allCities.count
    }
    
    init(cityService: CityService){
        self.cityService = cityService
    }
    
    func attachView(_ view: CityView) {
        cityView = view
    }
    
    func detachView() {
        cityView = nil
    }
    
    func getCities() {
        cityService.getCities{ [weak self] cities in
            if cities.count > 0 {
                let mappedCities = cities.map {
                    return CityViewData(name: "\($0.name), \($0.country)", coord: $0.coord)
                }
                self?.allCities = mappedCities
            }
        }
    }
    
    func configure(cell: CityCell, row: Int) {
        let city = allCities[row]
        cell.show(city: city)
    }
}