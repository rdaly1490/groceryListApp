//
//  AppDelegate+Extension.swift
//  GroceryList
//
//  Created by Rob Daly on 10/13/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}
