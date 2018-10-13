//
//  UIViewController+Extension.swift
//  GroceryList
//
//  Created by Rob Daly on 10/12/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    var coreData: CoreDataController {
        return CoreDataController.sharedInstance
    }
}
