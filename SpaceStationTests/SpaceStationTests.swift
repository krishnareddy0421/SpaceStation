//
//  SpaceStationTests.swift
//  SpaceStationTests
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import XCTest
@testable import SpaceStation

class SpaceStationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    /**
      * Check the number of passes received is matching the request object or not
     */
    func testSpacesCount() {
        //Get Newyork ISS passes
        APIManager.fetchISSPasses(latitude: 40.759211, longitude: -73.984638) { (response) in
            if let resp = response {
                XCTAssertEqual(resp.request.passes, resp.response.count)
            }
        }
    }
}
