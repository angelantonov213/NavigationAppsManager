//
//  CanOpenNavigationAppsTests.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import NavigationAppsManager

class CanOpenNavigationAppsTests: XCTestCase {
    
    var sut = MockPresentMethodViewController(nibName: nil, bundle: nil)
    
    func test_navigate_CallsViewController_PresentMethod() {
        let expectation = self.expectation(description: "Call present method")
        
        sut.didCall = {
            expectation.fulfill()
        }
        
        sut.navigate(CoreLocationStubs.simpleLocation, urlOpener: MockCanOpenAllURL())
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_navigate_To1App_DoesntCallViewController_PresentMethod() {
        let expectation = self.expectation(description: "Expect to open a browser directly")
        
        let mockCanOpenURL = MockCanOpenAllURL()
        mockCanOpenURL.didCallOpen = { _ in
            expectation.fulfill()
        }
        
        sut.didCall = {
            assertionFailure("Should not call present method")
        }
        
        sut.navigate(CoreLocationStubs.simpleLocation, appsToUse: [.google], urlOpener: mockCanOpenURL)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_navigate_ToNotSetAppScheme_DoesntCallViewController_PresentMethod() {
        let expectation = self.expectation(description: "Expect to open a browser directly")
        
        let mockCanOpenURL = MockCanOpenNoURL()
        mockCanOpenURL.didCallOpen = { url in
            if url.absoluteString.contains("http://maps.google.com") {
                expectation.fulfill()
                return
            }
        }
        
        sut.didCall = {
            assertionFailure("Should not call present method")
        }
        
        sut.navigate(CoreLocationStubs.simpleLocation, appsToUse: [.google, .maps], urlOpener: mockCanOpenURL)
        
        wait(for: [expectation], timeout: 1.0)
    }

}
