//
//  Helper.swift
//  GRIT
//
//  Created by Jared Williams on 10/19/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    static func createNavigationController(viewController: UIViewController, barColor: UIColor, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.navigationBar.tintColor = barColor
        nav.navigationBar.topItem?.title = title
        
        return nav
    }
}
