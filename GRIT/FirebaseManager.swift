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
    private var isUserSignedIn: Bool = false
    private var currentUid: String!
    private var currentUser: User!
    
    
    
    
    
    func getUserAuthStatus() -> Bool{
        return self.isUserSignedIn
    }
    
    
    
    func createUser(user: User, completion: (() -> ())?) {
        
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
                self.createCustomUser(user: user, completion: completion)
            }
        }
    }
    
    func createCustomUser(user: User, completion: (() -> ())?) {
        var dictionary = Dictionary<String, String>()
        dictionary["First Name"] = user.firstName
        dictionary["Last Name"] = user.lastName
        dictionary["Age"] = user.age
        dictionary["Description"] = user.description
        self.databaseReference.child(user.uid).setValue(dictionary)
        self.currentUser = user
        completion?()
    }
    
    func getCurrentUser() -> User{
 
       return self.currentUser
    }
    
    func loginUser(email: String, password: String, completion: (()->())?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            let userReturn = User()
            
            guard let uid = user?.uid else {return }
            
            if error == nil {
                print("User login success")
                
                self.isUserSignedIn = true
                userReturn.uid = uid
                userReturn.email = user?.email
                
                let dictionary = self.getData(path: uid) // Get our saved info from the database
                
                userReturn.firstName = dictionary?["First Name"] as? String
                userReturn.lastName = dictionary?["Last Name"] as? String
                userReturn.age = dictionary?["Age"] as? String
                userReturn.description = dictionary?["Description"] as? String
                
            }
            
            self.currentUser = userReturn
            completion?()
        }
    }
    
    func getData(path: String) -> [String: AnyObject]? {
        
        var returnObject: [String: AnyObject]? = [:]
        
        self.databaseReference.child(path).observe(.value) { (snap: DataSnapshot) in
            if let object = snap.value as? [String: AnyObject] {
                print(snap)
                returnObject = object
            }
        }
        return returnObject
    }
    
    
    
    
    
    
    
}
