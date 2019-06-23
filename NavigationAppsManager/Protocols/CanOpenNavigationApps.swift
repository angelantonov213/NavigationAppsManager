//
//  CanOpenNavigationApps.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation

/**
 Protocol which enables module that implements it, to open Navigation Apps with location.
 */
public protocol CanOpenNavigationApps {
    /**
     Will try to open a navigation app with provided `LocationCoordinates`
     
     - Parameters:
         - toLocation: `CLLocation`, `CLLocationCoordinate2D` or other loaction object that implements `LocationCoordinates`
         - appsToUse: Array of `NavigationApp`s that will be shown (if available on the device) as options
         - urlOpener: Object that will handle of openning the url. Default is `UIApplication.shared`
     
     There is a default implementation for `UIView` and `UIViewController`.
     */
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationAppTypes], urlOpener: CanOpenURL)
}

public extension CanOpenNavigationApps where Self: UIViewController {
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationAppTypes] = NavigationAppTypes.defaultOrder, urlOpener: CanOpenURL = UIApplication.shared) {
        let navigationMapsManager = NavigationMapsManager(to: toLocation, appsToUse: appsToUse, urlOpener: urlOpener)
        navigationMapsManager.presentOptions(optionsShower:ActionSheetMapsOptionsShower(), from: self)
    }
}

public extension CanOpenNavigationApps where Self: UIView {
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationAppTypes] = NavigationAppTypes.defaultOrder, urlOpener: CanOpenURL = UIApplication.shared) {
        let navigationMapsManager = NavigationMapsManager(to: toLocation, appsToUse: appsToUse, urlOpener: urlOpener)
        navigationMapsManager.presentOptions(optionsShower:ActionSheetMapsOptionsShower(), from: self)
    }
}
