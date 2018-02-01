//
//  SpaceStationUITests.swift
//  SpaceStationUITests
//
//  Created by Krishna Kamjula on 24/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import XCTest
import CoreLocation

class SpaceStationUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        //Get the application
        let app = XCUIApplication()
        
        //IF its first time,wait for the location services and tap allow
        addUIInterruptionMonitor(withDescription: "Location Services") { (alert) -> Bool in
            alert.buttons["Allow"].tap()
            return true
        }
        
        //Then tap on the start btn to show the ISS Passes
        app.buttons["StartBtn"].tap()
        
        //Show ISS passes screen
        XCTAssert(app.navigationBars["ISS Passes"].exists)
    }
}
