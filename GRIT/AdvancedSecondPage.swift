//
//  AdvancedSecondPage.swift
//  GRIT
//
//  Created by Jake Alvord on 1/9/18.
//  Copyright © 2018 CodeThatCares. All rights reserved.
//

import UIKit

class AdvancedSecondPage : UIViewController {
    
    override func viewDidLoad() {
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        let welcome = UILabel()
        welcome.frame = CGRect(x: 0, y: 0, width: width, height: height/3)
        welcome.text = "Welcome to GRIT!"
        welcome.textAlignment = .center
        welcome.font = UIFont.systemFont(ofSize: 36)
        welcome.textColor = UIColor.white
        welcome.backgroundColor = UIColor.black
        
        let message = UILabel()
        message.frame = CGRect(x: 0, y: height/3, width: width, height: height/3)
        message.text = "This tutorial will outline some helpful hints and tips to get you familiarized with using our app"
        message.textAlignment = .center
        message.font = UIFont.systemFont(ofSize: 28)
        message.textColor = UIColor.white
        message.backgroundColor = UIColor.black
        message.numberOfLines = 3
        
        let swipe = UILabel()
        swipe.frame = CGRect(x: 0, y: 2*height/3, width: width, height: height/3)
        swipe.text = "Swipe to the left to go through the tutorial"
        swipe.textAlignment = .center
        swipe.font = UIFont.systemFont(ofSize: 14)
        swipe.textColor = UIColor.white
        swipe.backgroundColor = UIColor.black
        
        self.view.addSubview(welcome)
        self.view.addSubview(message)
        self.view.addSubview(swipe)
    }
    
}
