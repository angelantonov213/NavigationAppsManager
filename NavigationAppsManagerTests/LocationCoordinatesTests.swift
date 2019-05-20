//
//  LocationCoordinatesTests.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 20.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import NavigationAppsManager

class LocationCoordinatesTests: XCTestCase {
    
    func test_CLLocation_ReturnCorrectValues() {
        let location = CLLocation(latitude: 1.0, longitude: 1.0)
        let locationCoordinates = location as LocationCoordinates
        
        XCTAssertEqual(location.coordinate.latitude, locationCoordinates.lcLatitude)
        XCTAssertEqual(location.coordinate.longitude, locationCoordinates.lcLongitude)
    }
    
    func test_CLLocationCoordinate2D_ReturnCorrectValues() {
        let location = CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
        let locationCoordinates = location as LocationCoordinates
        
        XCTAssertEqual(location.latitude, locationCoordinates.lcLatitude)
        XCTAssertEqual(location.longitude, locationCoordinates.lcLongitude)
    }

}
