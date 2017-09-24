//
//  User.swift
//  GRIT
//
//  Created by Jared Williams on 9/24/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import Foundation


struct User {
    var email: String!
    var password: String!
    var firstName: String!
    var lastName: String!
    var age: Int!
    var uid: String!
    
    init(email: String, password: String!) {
        self.email = email
        self.password = password
    }
    
    init() {
        
    }
}
