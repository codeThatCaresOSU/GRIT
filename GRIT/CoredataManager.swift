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
            
            
        }
        
        
        return container
    }()
    var userHasLoggedIn = false
    
    
    
    
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
            let setting = try self.persistentContainer.viewContext.fetch(Setting.fetchRequest())
            completion?(setting as? [Setting])
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
        completion?()
    }
    
    
    
}
