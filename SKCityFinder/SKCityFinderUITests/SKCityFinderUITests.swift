//
//  SKCityFinderUITests.swift
//  SKCityFinderUITests
//
//  Created by Syrine Ferjani on 9.12.2019.
//  Copyright © 2019 Syrine Ferjani. All rights reserved.
//

import XCTest

class SKCityFinderUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        print(app.debugDescription)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testAboutScreen() {
        let firstCell = app.tables["table"].cells["cell1"]
        firstCell.buttons["More Info"].tap()
        
        sleep(1)
        
        let closeButton = app.buttons["close"]
        closeButton.tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
