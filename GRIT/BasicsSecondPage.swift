//
//  BasicsSecondPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

class BasicsSecondPage : UIViewController {
    
    override func viewDidLoad() {
        
        let welcome = UILabel()
        welcome.frame = self.view.bounds
        welcome.text = "Welcome!"
        welcome.textAlignment = .center
        welcome.font = UIFont.systemFont(ofSize: 36)
        welcome.textColor = UIColor.white
        welcome.backgroundColor = UIColor.black
        
        self.view.addSubview(welcome)
    }

}

