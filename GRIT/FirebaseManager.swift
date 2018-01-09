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
import MapKit

class FirebaseManager  {
    static var sharedInstance = FirebaseManager()
    private var databaseReference = Database.database().reference().child("Users")
    private var dataBaseMapReference = Database.database().reference().child("MapData").child("OhioData")
    private var isUserSignedIn: Bool = false
    private var currentUid: String!
    private var currentUser: User!
    
    
    func getUserAuthStatus() -> Bool{
        return self.isUserSignedIn
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error signing out")
        }
        
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
    
    func loginUser(email: String, password: String, completion: ((User)->())?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            let userReturn = User()
            
            guard let uid = user?.uid else {return }
            guard let email = user?.email else {return}
            
            if error == nil {
                print("User login success")
                
                self.isUserSignedIn = true
                userReturn.uid = uid
                userReturn.email = email
                
                self.databaseReference.child(uid).observeSingleEvent(of: .value) { (snap: DataSnapshot) in
                    if let data = snap.value as? [String: AnyObject] {
                        userReturn.firstName = data["First Name"] as? String
                        userReturn.lastName = data["Last Name"] as? String
                        userReturn.age = data["Age"] as? String
                        userReturn.description = data["Description"] as? String
                        self.currentUser = userReturn
                        completion?(userReturn)
                    }
                }
            }
        }
    }
    
    func getBusinesses(flags: Array<String>, completion: @escaping (Array<Business>) -> ()) {
        
        var businesses = [Business]()
        
        dataBaseMapReference.observe(.value, with: { (snapshot: DataSnapshot) in
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot
            
                if let data = snap.value as? [String: AnyObject] {
                
                    let business = Business()
                
                    business.name = data["name"] as? String
                    business.category = data["category"] as? String
                    business.street = data["address"] as? String
                    business.city = data["city"] as? String
                    business.state = data["state"] as? String
                    business.zip = data["zip"] as? Int
                    business.phone = data["phone"] as? String
                    business.lat = data["lat"] as? Double
                    business.long = data["lng"] as? Double
                    business.url = data["url"] as? String
                    
                    if business.lat == nil || business.long == nil {
                        
                        var address = ""
                        address.append(business.street)
                        address.append(", ")
                        address.append(business.city)
                        address.append(", ")
                        address.append(business.state)
                        address.append(", ")
                        
                        if business.zip != nil {
                            address.append(String(business.zip!))
                        }
                        
                        let geo_coder = CLGeocoder()
                        
                        geo_coder.geocodeAddressString(address) { (placemarks, error) in
                            guard
                                let placemarks = placemarks,
                                let location = placemarks.first?.location
                                else {
                                    // handle no location found
                                    return
                            }
                            
                            business.lat = location.coordinate.latitude
                            business.long = location.coordinate.longitude
                            
                            self.dataBaseMapReference.child(String(describing: data)).child("lat").setValue(business.lat)
                            self.dataBaseMapReference.child(String(describing: data)).child("lng").setValue(business.long)
                            
                        }
                    }
                    
                    businesses.append(business)
                }
                
            }
           completion(businesses)
        })
    }
 
    
}
