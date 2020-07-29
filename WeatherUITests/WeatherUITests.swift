//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by Anton Tolstov on 28.07.2020.
//  Copyright © 2020 VTB. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    func testCityDeletion() throws {
        app.buttons["toggle_style"].tap()
        
        let weatherCells = app.cells
        let weatherCellCount = weatherCells.count
                
        let firstCell = weatherCells.firstMatch
        firstCell.swipeLeft()
        
        XCTAssertEqual(weatherCellCount - 1, weatherCells.count)
    }
    
    func testCityAddition() throws {
        XCTAssertFalse(app.cells["Toronto"].exists)
               
        app.buttons["toggle_style"].tap()
        app.buttons["add_city"].tap()
        
        "Toronto".forEach { app.keys["\($0)"].tap() }
        app.tables.element.cells.element.tap()
                
        XCTAssert(app.cells["Toronto"].exists)
    }
    
    func testSwipes() throws {
        // Just for studying purposes
        
        let leftSwipeRange = (0...app.cells.count + 2)
        let weatherCollection = app.collectionViews.element
        
        (1...2).forEach { _ in weatherCollection.swipeRight() }
        leftSwipeRange.forEach { _ in weatherCollection.swipeLeft() }
        
        app.buttons["toggle_style"].tap()
        weatherCollection.swipeUp()
        weatherCollection.swipeDown()
    }
}
