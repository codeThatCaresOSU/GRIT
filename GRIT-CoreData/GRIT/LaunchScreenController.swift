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
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleLogin), name: Notification.Name(rawValue: "login"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleLogout), name: Notification.Name(rawValue: "logout"), object: nil)
        
        tabBar.items?[0].title = "Resources"
        tabBar.items?[0].image = #imageLiteral(resourceName: "place.png")
        tabBar.items?[1].title = "My Account"
        tabBar.items?[1].image = #imageLiteral(resourceName: "user.png")
    }
    
    func get_height() -> CGFloat {
        return tabBar.frame.size.height
    }
    
    @objc func handleLogin() {
        self.viewControllers![1] = Helpers.createNavigationController(viewController: ProfileViewController(), barColor: UIColor.white, title: "Profile")
        tabBar.items?[1].title = "My Account"
        tabBar.items?[1].image = #imageLiteral(resourceName: "user.png")
    }
    
    @objc func handleLogout() {
        self.viewControllers![1] = Helpers.createNavigationController(viewController: SignInViewController(), barColor: UIColor.white, title: "Sign Up")
        tabBar.items?[1].title = "My Account"
        tabBar.items?[1].image = #imageLiteral(resourceName: "user.png")
    }
    
}
