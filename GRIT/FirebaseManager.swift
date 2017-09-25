//
//  FirebaseManager.swift
//  GRIT
//
//  Created by Jared Williams on 9/24/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class FirebaseManager  {
    static var sharedInstance = FirebaseManager()
    private var databaseReference = Database.database().reference().child("Users")
    private var isUserSignedIn: Bool!
    private var currentUid: String!
    
    
    
    func createUser(user: User) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (firUser, error) in
            if error != nil {
                self.isUserSignedIn = false
                print("Error signing user up \(String(describing: error?.localizedDescription))")
            }
            
            else {
                self.isUserSignedIn = true
                self.currentUid = firUser?.uid
                user.uid = self.currentUid
                print("User Creation Success")
                self.createCustomUser(user: user)
            }
        }
    }
    
    func createCustomUser(user: User) {
        
        
        
        
        var dictionary = Dictionary<String, String>()
        dictionary["First Name"] = user.firstName
        dictionary["Last Name"] = user.lastName
        dictionary["Age"] = user.age
        dictionary["Description"] = user.description
        self.databaseReference.child(user.uid).setValue(dictionary)
    }
    
    
    
    
    
    
    
}
