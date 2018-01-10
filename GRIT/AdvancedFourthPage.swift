//
//  AdvancedFourthPage.swift
//  GRIT
//
//  Created by Jake Alvord on 1/9/18.
//  Copyright © 2018 CodeThatCares. All rights reserved.
//

import UIKit

protocol AdvancedFourthPageDelegate {
    func dismiss_advanced_last()
}

protocol AdvancedBackToFirst {
    func back_to_beginning()
}

class AdvancedFourthPage : UIViewController {
    
    var delegate: AdvancedFourthPageDelegate! = nil
    var redelegate: AdvancedBackToFirst! = nil
    
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
        
        let question = UILabel()
        question.frame = CGRect(x: width/8, y: 0, width: 3*width/4, height: height/2)
        question.text = "There ya go! That should help you out.\n\nThanks again for using GRIT!"
        question.numberOfLines = 8
        question.textColor = UIColor.white
        question.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.thin)
        question.textAlignment = .center
        
        let button = UIButton()
        button.frame = CGRect(x: width/8, y: height/2 + status_bar_height, width: 3*width/4, height: height/8)
        button.backgroundColor = UIColor.green
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("I'm all set!", for: .normal)
        button.addTarget(self, action: #selector(last_dismiss), for: .touchUpInside)
        
        let redo = UIButton()
        redo.frame = CGRect(x: width/8, y: 3*height/4, width: 3*width/4, height: height/8)
        redo.backgroundColor = UIColor.red
        redo.layer.cornerRadius = 10
        redo.layer.masksToBounds = true
        redo.setTitle("I need another go around", for: .normal)
        redo.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.view.addSubview(background)
        self.view.addSubview(question)
        self.view.addSubview(redo)
        self.view.addSubview(button)
    }
    
    @objc func last_dismiss() {
        self.delegate.dismiss_advanced_last()
    }
    
    @objc func back() {
        self.redelegate.back_to_beginning()
    }
}
