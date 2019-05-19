//
//  Presentable.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation

public protocol Presentable {
    func present(itemToPresent: Presentable)
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
