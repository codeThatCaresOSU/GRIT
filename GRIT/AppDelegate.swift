//
//  AppDelegate.swift
//  GRIT
//
//  Created by Taha Topiwala on 3/29/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit
import Firebase


let colorMaster = UIColor(displayP3Red: 222/255, green: 49/255, blue: 99/255, alpha: 1)
let successColor = UIColor(displayP3Red: 102/255, green: 255/255, blue: 153/255, alpha: 1)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        
        FirebaseApp.configure()
        
        // Check if user has logged in before
        
        CoredataManager.sharedInstance.getUserData { (settings: [Setting]?) in
            if let settingsData = settings {
                if settingsData.count > 0 {
                    FirebaseManager.sharedInstance.loginUser(email: settingsData[0].email!, password: settingsData[0].password!, completion: { (user: User) in
                        CoredataManager.sharedInstance.userHasLoggedIn = true
                        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "login"), object: nil))
                    })
                }
            }
        }
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

