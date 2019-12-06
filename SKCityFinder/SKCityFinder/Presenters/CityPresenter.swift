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
    func showDetails(with presenter: DetailsPresenter)
}

protocol CityCell: class {
    func show(city: CityViewData)
}

class CityPresenter {
    fileprivate let cityService: CityService
    weak fileprivate var cityView : CityView?
    private var allCities = [CityViewData]() { didSet { citiesData = allCities } }
    private var citiesData = [CityViewData]() { didSet { cityView?.reload() } }

    var cityCount: Int {
        return citiesData.count
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
        let city = citiesData[row]
        cell.show(city: city)
    }
    
    func filterCities(with keyword: String) {
        if keyword.isEmpty {
            citiesData = allCities
        } else {
            citiesData = allCities.filter { $0.name.uppercased().hasPrefix(keyword.uppercased()) }
        }
    }
    
    func showDetails(row: Int) {
        let detailsPresenter = DetailsPresenter(with: citiesData[row])
        cityView?.showDetails(with: detailsPresenter)
    }
}
