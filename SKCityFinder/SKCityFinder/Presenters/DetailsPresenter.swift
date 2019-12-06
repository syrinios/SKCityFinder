//
//  DetailsPresenter.swift
//  SKCityFinder
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import Foundation

protocol DetailsView: class {
    func showDetails(location: Coord)
}

class DetailsPresenter {
    private weak var detailView: DetailsView?
    private(set) var detailsModel: CityViewData?
    
    init(with city: CityViewData) {
        detailsModel = city
    }
    
    func attachView(_ view: DetailsView) {
        detailView = view
    }
    
    func detachView() {
        detailView = nil
    }
    
    func show() {
        guard let coord = detailsModel?.coord else { return }
        detailView?.showDetails(location: coord)
    }
}
