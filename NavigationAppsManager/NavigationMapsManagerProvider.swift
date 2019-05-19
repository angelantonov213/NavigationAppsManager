//
//  NavigationMapsManagerProvider.swift
//  EKO
//
//  Created by iHustle on 10.09.18.
//  Copyright © 2018 CNG. All rights reserved.
//

import UIKit
import CoreLocation

class ActionSheetMapsOptionsShower: NavigationsOptionsShower {
    func showOptions(_ options: [NavigationApp], from: Presentable, selection: @escaping (NavigationApp) -> Void) {
        if options.count == 1, let onlyOption = options.first {
            selection(onlyOption)
            return
        }
        
        let alertController = UIAlertController(title: "Изберете навигация:", message: nil, preferredStyle: .actionSheet)
        
        for nav in options {
            let action = UIAlertAction(title: nav.title, style: UIAlertAction.Style.default) { (action) in
                selection(nav)
            }
            
            alertController.addAction(action)
        }
        
        let actionCancel = UIAlertAction(title: "Затвори", style: .cancel) { (action) in
            
        }
        
        alertController.addAction(actionCancel)
        
        from.present(itemToPresent: alertController)
    }
}

class AlertMapsOptionsShower: NavigationsOptionsShower {
    func showOptions(_ options: [NavigationApp], from: Presentable, selection: @escaping (NavigationApp) -> Void) {
        if options.count == 1, let onlyOption = options.first {
            selection(onlyOption)
            return
        }
        
        let alertController = UIAlertController(title: "Изберете навигация:", message: nil, preferredStyle: .alert)
        
        for nav in options {
            let action = UIAlertAction(title: nav.title, style: UIAlertAction.Style.default) { (action) in
                selection(nav)
            }
            
            alertController.addAction(action)
        }
        
        let actionCancel = UIAlertAction(title: "Затвори", style: .cancel) { (action) in
            
        }
        
        alertController.addAction(actionCancel)
        
        from.present(itemToPresent: alertController)
    }
}

extension UIViewController: Presentable {
    public func present(itemToPresent: Presentable) {
        switch itemToPresent {
        case is UIViewController:
            self.present(itemToPresent as! UIViewController, animated: true)
        case is UIView:
            self.view.addSubview(itemToPresent as! UIView)
        default:
            return
        }
    }
}

extension UIView: Presentable {
    public func present(itemToPresent: Presentable) {
        switch itemToPresent {
        case is UIViewController:
            self.addSubview((itemToPresent as! UIViewController).view)
        case is UIView:
            self.addSubview(itemToPresent as! UIView)
        default:
            return
        }
    }
}

public extension CanOpenNavigationApps where Self: UIViewController {
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationApp] = NavigationApp.defaultOrder) {
        let navigationMapsManager = NavigationMapsManager(to: toLocation, appsToUse: appsToUse, urlOpener: UIApplication.shared)
        navigationMapsManager.presentOptions(optionsShower:ActionSheetMapsOptionsShower(), from: self)
    }
}

public extension CanOpenNavigationApps where Self: UIView {
    func navigate(_ toLocation:LocationCoordinates, appsToUse: [NavigationApp] = NavigationApp.defaultOrder) {
        let navigationMapsManager = NavigationMapsManager(to: toLocation, appsToUse: appsToUse, urlOpener: UIApplication.shared)
        navigationMapsManager.presentOptions(optionsShower:ActionSheetMapsOptionsShower(), from: self)
    }
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

extension UIApplication: CanOpenURL {
    func canOpenURL(url: URL) -> Bool {
        return self.canOpenURL(url)
    }
    
    func open(url: URL) {
        return self.open(url, options: [:], completionHandler: nil)
    }
}


