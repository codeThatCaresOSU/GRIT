//
//  BasicsThirdPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

class BasicsThirdPage : UIViewController {
    
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
        image.image = #imageLiteral(resourceName: "tutorial_1.jpeg")
        image.frame = CGRect(x: (width - 3*width/4)/2, y: status_bar_height*2, width: 3*width/4, height: 3*height/4)
        
        let message = UILabel()
        message.frame = CGRect(x: width/8, y: (3 * height)/4 + status_bar_height*3, width: 3*width/4, height: height/8)
        message.text = "Tap here in order to filter what resources you want to see"
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
