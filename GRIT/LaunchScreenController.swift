//
//  LaunchScreenController.swift
//  GRIT
//
//  Created by Jake Alvord on 4/30/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//


import UIKit

class LaunchScreenController : UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.items?[0].title = "Resources"
        tabBar.items?[0].image = #imageLiteral(resourceName: "place.png")
        tabBar.items?[1].title = "My Account"
        tabBar.items?[1].image = #imageLiteral(resourceName: "user.png")
        
    }
    
    func get_height() -> CGFloat {
        return tabBar.frame.size.height
    }
    
}
