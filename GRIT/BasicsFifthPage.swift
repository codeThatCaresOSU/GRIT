//
//  BasicsFifthPage.swift
//  GRIT
//
//  Created by Jake Alvord on 1/9/18.
//  Copyright © 2018 CodeThatCares. All rights reserved.
//

import UIKit

class BasicsFifthPage : UIViewController {
    
    var gradientLayer: CAGradientLayer!
    var light_blue = UIColor(red: 0.0/255.0, green: 191.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        let status_bar_height = UIApplication.shared.statusBarFrame.height
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.orange.cgColor, light_blue.cgColor]

        let background = UIView()
        background.frame = self.view.bounds
        background.layer.addSublayer(gradientLayer)
        
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "tutorial_3.jpeg")
        image.frame = CGRect(x: (width - 5*width/8)/2, y: status_bar_height*2, width: 5*width/8, height: 5*height/8)
        
        let message = UILabel()
        message.frame = CGRect(x: width/8, y: 5*height/8 + status_bar_height*3, width: 3*width/4, height: height/4)
        message.text = "Tap on any map location to have more buttons appear. The blue will redirect you to the businesses website while the red will show you the location in Maps. Tap anywhere else on the screen to make them disappear"
        message.layer.cornerRadius = 10
        message.layer.masksToBounds = true
        message.numberOfLines = 10
        message.font = UIFont.systemFont(ofSize: 16)
        message.textAlignment = .center

        self.view.addSubview(background)
        self.view.addSubview(image)
        self.view.addSubview(message)
    }
    
}
