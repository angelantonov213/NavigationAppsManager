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
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationApp], urlOpener: CanOpenURL)
}

public extension CanOpenNavigationApps where Self: UIViewController {
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationApp] = NavigationApp.defaultOrder, urlOpener: CanOpenURL = UIApplication.shared) {
        let navigationMapsManager = NavigationMapsManager(to: toLocation, appsToUse: appsToUse, urlOpener: urlOpener)
        navigationMapsManager.presentOptions(optionsShower:ActionSheetMapsOptionsShower(), from: self)
    }
}

public extension CanOpenNavigationApps where Self: UIView {
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationApp] = NavigationApp.defaultOrder, urlOpener: CanOpenURL = UIApplication.shared) {
        let navigationMapsManager = NavigationMapsManager(to: toLocation, appsToUse: appsToUse, urlOpener: urlOpener)
        navigationMapsManager.presentOptions(optionsShower:ActionSheetMapsOptionsShower(), from: self)
    }
}
