//
//  CanOpenURL.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation

public protocol CanOpenURL {
    func canOpenURL(url: URL) -> Bool
    func open(url: URL)
}

extension UIApplication: CanOpenURL {
    public func canOpenURL(url: URL) -> Bool {
        return self.canOpenURL(url)
    }
    
    public func open(url: URL) {
        return self.open(url, options: [:], completionHandler: nil)
    }
}
