//
//  MockPresentMethodViewController.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import UIKit
@testable import NavigationAppsManager

class MockPresentMethodViewController: UIViewController, CanOpenNavigationApps {
    var didCall: (() -> Void)!
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.didCall()
    }
}
