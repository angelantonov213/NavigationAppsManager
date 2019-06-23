//
//  NavigationAppEnum.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation

public enum NavigationAppTypes: String {
    /** Google Maps. Needs _comgooglemaps://_ */
    case google
    /** Apple Maps */
    case maps
    /** Waze. Needs _waze://_ */
    case waze
    /** Here WeGo. Needs _here-route://_ */
    case here
    /** Fallback option if no apps are available. Will open browser with Google Maps url. */
    case none
    
    /**
     Default order to present the navigation apps.
     1. Maps (iOS)
     2. Google Maps
     3. Waze
     4. Here WeGo
     
     Note: Schemes should be set in order to load the navigation apps.
     */
    public static var defaultOrder: [NavigationAppTypes] {
        return [maps, google, waze, here]
    }
}


