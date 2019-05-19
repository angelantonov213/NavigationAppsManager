//
//  MockCanOpenNoURL.swift
//  NavigationAppsManagerTests
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation
@testable import NavigationAppsManager

class MockCanOpenNoURL: CanOpenURL {
    var didCallCanOpenURL : (() -> ())?
    var didCallOpen: ((URL) -> Void)?
    
    func canOpenURL(url: URL) -> Bool {
        self.didCallCanOpenURL?()
        return false
    }
    
    func open(url: URL) {
        self.didCallOpen?(url)
    }
    
    
}

