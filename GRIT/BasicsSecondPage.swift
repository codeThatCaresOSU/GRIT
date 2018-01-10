//
//  BasicsSecondPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

class BasicsSecondPage : UIViewController {
    
    var gradientLayer: CAGradientLayer!
    var light_blue = UIColor(red: 0.0/255.0, green: 191.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
                
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, light_blue.cgColor]
        
        let background = UIView()
        background.frame = self.view.bounds
        background.layer.addSublayer(gradientLayer)
        
        let welcome = UILabel()
        welcome.frame = CGRect(x: width/8, y: 0, width: 3*width/4, height: height/3)
        welcome.text = "Welcome to GRIT!"
        welcome.textAlignment = .center
        welcome.font = UIFont.systemFont(ofSize: 36)
        welcome.textColor = UIColor.white
        
        let message = UILabel()
        message.frame = CGRect(x: width/8, y: height/3, width: 3*width/4, height: height/3)
        message.text = "This tutorial will outline some helpful hints and tips to get you familiarized with using our app"
        message.textAlignment = .center
        message.font = UIFont.systemFont(ofSize: 28)
        message.textColor = UIColor.white
        message.numberOfLines = 8
        
        let swipe = UILabel()
        swipe.frame = CGRect(x: width/8, y: 2*height/3, width: 3*width/4, height: height/3)
        swipe.text = "Swipe to the left to go through the tutorial"
        swipe.textAlignment = .center
        swipe.font = UIFont.systemFont(ofSize: 14)
        swipe.textColor = UIColor.white
        
        self.view.addSubview(background)
        self.view.addSubview(welcome)
        self.view.addSubview(message)
        self.view.addSubview(swipe)
    }

}

