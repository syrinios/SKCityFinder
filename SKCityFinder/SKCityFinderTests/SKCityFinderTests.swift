//
//  SKCityFinderTests.swift
//  SKCityFinderTests
//
//  Created by Syrine Ferjani on 6.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import XCTest
@testable import SKCityFinder

class SKCityFinderTests: XCTestCase {
    var presenter: CityPresenter?

    override func setUp() {
        super.setUp()
        presenter = CityPresenter(cityService: CityService())
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }

    func testFiltering() {
        let key = "bizer"
        let key2 = "BB"
        presenter?.getCities()
        
        presenter?.filterCities(with: key)
        XCTAssertEqual(presenter?.cityCount, 1, "filter is wrong")
        
        presenter?.filterCities(with: key2)
        XCTAssertEqual(presenter?.cityCount, 0, "filter is wrong")
    }
}
