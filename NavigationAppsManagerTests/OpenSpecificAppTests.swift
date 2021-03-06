//
//  OpenSpecificAppTests.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import NavigationAppsManager

class OpenSpecificAppTests: XCTestCase {
    
    var sut = MockPresentMethodViewController(nibName: nil, bundle: nil)    
    
    func _test_navigate_OpenMaps() {
        let app: NavigationApp = .maps
        
        let expectationCallOpen = self.expectation(description: "Expect to open \(app.title)")
        let expectationCallCanOpen = self.expectation(description: "Expect to check for \(app.title)")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        mockCanOpenURL.didCallOpen = { url in
            if url.absoluteString.contains(app.scheme) {
                expectationCallOpen.fulfill()
            }
        }
        
        mockCanOpenURL.didCallCanOpenURL = { url in
            if url.absoluteString.contains(app.scheme) {
                expectationCallCanOpen.fulfill()
            }
        }
        
        sut.didCall = { _ in
            assertionFailure("Should not call present method when testing \(app.title)")
        }
        
        sut.navigate(CoreLocationStubs.simpleLocation, appsToUse: [app], urlOpener: mockCanOpenURL)
        
        wait(for: [expectationCallOpen, expectationCallCanOpen], timeout: 1.0)
    }
    
    func test_navigate_ToGoogleMapsApp() {
        let apps: [NavigationApp] = [.google, .here, .waze]
        for app in apps {
            self.open(app: app)
        }
    }
    
    private func open(app: NavigationApp) {
        let expectationCallOpen = self.expectation(description: "Expect to open \(app.title)")
        let expectationCallCanOpen = self.expectation(description: "Expect to check for \(app.title)")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        mockCanOpenURL.didCallOpen = { url in
            if url.absoluteString.contains(app.scheme) {
                expectationCallOpen.fulfill()
            }
        }
        
        mockCanOpenURL.didCallCanOpenURL = { url in
            if url.absoluteString.contains(app.scheme) {
                expectationCallCanOpen.fulfill()
            }
        }
        
        sut.didCall = { _ in
            assertionFailure("Should not call present method when testing \(app.title)")
        }
        
        sut.navigate(CoreLocationStubs.simpleLocation, appsToUse: [app], urlOpener: mockCanOpenURL)
        
        wait(for: [expectationCallOpen, expectationCallCanOpen], timeout: 1.0)
    }

}
