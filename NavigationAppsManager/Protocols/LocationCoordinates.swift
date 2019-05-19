//
//  LocationCoordinates.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Wrapper protocol for passing _Latitude_ and _Longitude_ values.
 
 Implemented for `CLLocation` and `CLLocationCoordinate2D`
 */
public protocol LocationCoordinates {
    var lcLatitude: Double { get }
    var lcLongitude: Double { get }
}

extension CLLocation: LocationCoordinates {
    public var lcLatitude: Double {
        get {
            return self.coordinate.latitude
        }
    }
    
    public var lcLongitude: Double {
        get {
            return self.coordinate.longitude
        }
    }
}

extension CLLocationCoordinate2D: LocationCoordinates {
    public var lcLatitude: Double {
        get {
            return self.latitude
        }
    }
    
    public var lcLongitude: Double {
        get {
            return self.longitude
        }
    }
}
