//
//  CoredataManager.swift
//  GRIT
//
//  Created by Jared Williams on 9/24/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoredataManager {
    static var sharedInstance = CoredataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Setting")
        container.loadPersistentStores() { (storeDescriptor: NSPersistentStoreDescription, error: Error?) in
            // TO-DO: Error checking
        }
        return container
    }()
    var userHasLoggedIn = false
    private var currentUserSetting: Setting!
    
    
    
    
    func save() {
        do {
            try self.persistentContainer.viewContext.save()
        }
        
        catch {
            print("Error saving user data")
        }
    }
    
    
    func getUserData(completion: ( ([Setting]?) -> () )?) {

        
        do {
            let setting = try self.persistentContainer.viewContext.fetch(Setting.fetchRequest()) as [Setting]
            
            if setting.count > 0 {
                self.currentUserSetting  = setting[0]
                completion?(setting as? [Setting])
            }
        }
        
        catch {
            print("Error retrieving user data")
        }
    }
    
    
    
    func setUserData(email: String, password: String, completion: (() -> ())?) {
        
        let userSettings = Setting(context: self.persistentContainer.viewContext)
        userSettings.email = email
        userSettings.password = password
        self.save()
        self.userHasLoggedIn = true
        
        self.currentUserSetting = userSettings
        completion?()
    }
    
    func deleteUserData() {
        self.persistentContainer.viewContext.delete(self.currentUserSetting)
        self.save()
    }
    
    
    
}
