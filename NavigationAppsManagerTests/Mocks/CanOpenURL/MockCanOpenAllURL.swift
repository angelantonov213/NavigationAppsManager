//
//  MockCanOpenAllURL.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation
@testable import NavigationAppsManager

class MockCanOpenAllURL: CanOpenURL {
    var didCallCanOpenURL : ((URL) -> Void)?
    var didCallOpen: ((URL) -> Void)?
    
    func canOpenURL(url: URL) -> Bool {
        self.didCallCanOpenURL?(url)
        return true
    }
    
    func open(url: URL) {
        self.didCallOpen?(url)
    }
    
    
}
