//
//  NavigationMapsManagerTests.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 20.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import XCTest
import UIKit
@testable import NavigationAppsManager

class NavigationMapsManagerTests: XCTestCase {
    
    var vc = MockPresentMethodViewController(nibName: nil, bundle: nil)
    
    func test_OnInit_NoNavigationApps_OpensBrowser() {
        let expectation = self.expectation(description: "Try to show action sheet with 1 option")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        mockCanOpenURL.didCallOpen = { _ in
            expectation.fulfill()
        }
        
        let manager = NavigationMapsManager(to: CoreLocationStubs.simpleLocation, appsToUse: [], urlOpener: mockCanOpenURL)
        
        manager.presentOptions(optionsShower: ActionSheetMapsOptionsShower(), from: vc)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_OnInit_2NavigationApps_OpensBrowser() {
        let expectation = self.expectation(description: "Will show 2 navigation apps")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        
        let manager = NavigationMapsManager(to: CoreLocationStubs.simpleLocation, appsToUse: [.google, .here], urlOpener: mockCanOpenURL)
        
        vc.didCall = { vc in
            if let vc = vc as? UIAlertController {
                if vc.actions.count == 3 {
                    expectation.fulfill()
                }
            }
        }
        
        manager.presentOptions(optionsShower: ActionSheetMapsOptionsShower(), from: vc)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_WillOpenCorrectNavigationApp_FromActionSheet() {
        let expectation = self.expectation(description: "Alert controller will open correct action sheet")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        
        let manager = NavigationMapsManager(to: CoreLocationStubs.simpleLocation, appsToUse: [.google, .here], urlOpener: mockCanOpenURL)
        
        mockCanOpenURL.didCallOpen = { url in
            if url.absoluteString.contains(NavigationAppsFactory().createNavigationApp(navApp: .here).scheme) {
                expectation.fulfill()
                return
            }
        }
        
        vc.didCall = { vc in
            if let vc = vc as? UIAlertController {
                vc.tapButton(atIndex: 1)
            }
        }
        
        manager.presentOptions(optionsShower: ActionSheetMapsOptionsShower(), from: vc)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_WillOpenCorrectNavigationApp_FromAlert() {
        let expectation = self.expectation(description: "Alert controller will open correct action sheet")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        
        let manager = NavigationMapsManager(to: CoreLocationStubs.simpleLocation, appsToUse: [.google, .here], urlOpener: mockCanOpenURL)
        
        mockCanOpenURL.didCallOpen = { url in
            if url.absoluteString.contains(NavigationAppsFactory().createNavigationApp(navApp: .here).scheme) {
                expectation.fulfill()
                return
            }
        }
        
        vc.didCall = { vc in
            if let vc = vc as? UIAlertController {
                vc.tapButton(atIndex: 1)
            }
        }
        
        manager.presentOptions(optionsShower: AlertMapsOptionsShower(), from: vc)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_WillOpenCorrectNavigationApp_FromView() {
        let expectation = self.expectation(description: "Alert controller will open correct action sheet")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        
        let manager = NavigationMapsManager(to: CoreLocationStubs.simpleLocation, appsToUse: [.google, .here], urlOpener: mockCanOpenURL)
        
        mockCanOpenURL.didCallOpen = { url in
            if url.absoluteString.contains(NavigationAppsFactory().createNavigationApp(navApp: .here).scheme) {
                expectation.fulfill()
                return
            }
        }
        
        vc.didCall = { vc in
            if let vc = vc as? UIAlertController {
                vc.tapButton(atIndex: 1)
            }
        }
        
        manager.presentOptions(optionsShower: AlertMapsOptionsShower(), from: vc.view)
        
        wait(for: [expectation], timeout: 1.0)
    }

}


extension UIAlertController {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void
    
    func tapButton(atIndex index: Int) {
        guard let block = actions[index].value(forKey: "handler") else { return }
        let handler = unsafeBitCast(block as AnyObject, to: AlertHandler.self)
        handler(actions[index])
    }
}
