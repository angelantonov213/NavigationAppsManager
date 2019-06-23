//
//  NavigationMapsManager.swift
//  EKO
//
//  Created by iHustle on 19.07.18.
//  Copyright © 2018 iHustle. All rights reserved.
//

import Foundation
import MapKit

public class NavigationMapsManager {
    /*
     
     User workflow:
     1. Tap to navigate
     2. Choose from options - Google Maps app, Maps, Waze, HERE.
     2.1 If only one available directly use it
     2.2 If none available - redirect to Safari and maps.google.com
     
     NavigationMapsManager workflow:
     1. Get available options and return in array
     1.1 If no options available - open maps.google.com
     2. Open selected option
     
     */
    
    // MARK: - URL Opener
    private var urlOpener: CanOpenURL
    
    // MARK: - Location properties
    private var destinationLocation: LocationCoordinates
    
    // MARK: - Available navigation apps array
    private var canSetAvailableNavigationApps: Bool = true
    
    private var _availableNavigationApps: [NavigationAppTypes]
    private var availableNavigationApps: [NavigationAppTypes] {
        didSet {
            if self.canSetAvailableNavigationApps == false {
                return
            }
            
            if !oldValue.contains(.none) && availableNavigationApps.contains(.none) {
                self._availableNavigationApps = [.none]
            }
            else if oldValue.contains(.none) && oldValue.count == 1 {
                self._availableNavigationApps = availableNavigationApps.filter({ (navigationApp) -> Bool in
                    return navigationApp != .none
                })
            }
            else {
                self._availableNavigationApps = availableNavigationApps
            }
            
            self.canSetAvailableNavigationApps = false
            self.availableNavigationApps = _availableNavigationApps
            self.canSetAvailableNavigationApps = true
        }
    }
    
    // MARK: - Init method
    
    internal init(to destination: LocationCoordinates, appsToUse: [NavigationAppTypes], urlOpener: CanOpenURL = UIApplication.shared) {
        self.destinationLocation = destination
        self.urlOpener = urlOpener
        
        availableNavigationApps = [.none]
        _availableNavigationApps = [.none]
        
        self.checkForNavigationApps(appsToUse: appsToUse)
    }
    
    init(to destination: LocationCoordinates, appsToUse: [NavigationAppTypes]) {
        self.destinationLocation = destination
        self.urlOpener = UIApplication.shared
        
        availableNavigationApps = [.none]
        _availableNavigationApps = [.none]
        
        self.checkForNavigationApps(appsToUse: appsToUse)
    }
    
    /*
     Following schemes should be registered in app .plist under LSApplicationQueriesSchemes
     
     comgooglemaps
     waze
     here-route

     */
    private func checkForNavigationApps(appsToUse: [NavigationAppTypes]) {
        for app in appsToUse {
            if urlOpener.canOpenURL(url: URL(string: NavigationAppsFactory().createNavigationApp(navApp: app).scheme)!) {
                availableNavigationApps.append(app)
            }
        }
    }
    
    // MARK: - Presenting in UI
    
    internal func presentOptions(optionsShower: NavigationsOptionsShower, from: Presentable) {
        optionsShower.showOptions(self._availableNavigationApps, from: from) { (app) in
            self.openMapsWith(nav: app)
        }
    }
    
    // MARK: - Redirecting to navigation
    
    private func openMapsWith(nav: NavigationAppTypes) {
        NavigationAppsFactory().createNavigationApp(navApp: nav).open(with: destinationLocation, urlOpener: urlOpener)
    }
}
