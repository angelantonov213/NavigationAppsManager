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





