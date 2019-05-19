//
//  NavigationsOptionsShower.swift
//  NavigationAppsManager
//
//  Created by Angel Antonov on 19.05.19.
//  Copyright © 2019 Angel Antonov. All rights reserved.
//

import Foundation

public protocol NavigationsOptionsShower {
    func showOptions(_ options: [NavigationApp], from: Presentable, selection: @escaping (NavigationApp) -> Void)
}
