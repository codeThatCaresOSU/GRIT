//
//  BasicsThirdPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

protocol BasicsThirdPageDelegate {
    func dismiss_basics_third()
}

class BasicsThirdPage : UIViewController {
    
    var delegate: BasicsThirdPageDelegate! = nil
    
    override func viewDidLoad() {
        
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        let label = UILabel()
        label.frame = self.view.bounds
        label.backgroundColor = UIColor.black
        
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "tutorial_1.jpeg")
        image.frame = CGRect(x: (self.view.bounds.width - 3*self.view.bounds.width/4)/2, y: 0, width: 3*self.view.bounds.width/4, height: 3*self.view.bounds.height/4)
        
        let button = UIButton()
        button.frame = CGRect(x: width/4, y: (3 * height)/4, width: width/2, height: height/8)
        button.backgroundColor = UIColor.red
        button.setTitle("I'm all set!", for: .normal)
        button.addTarget(self, action: #selector(third_dismiss), for: .touchUpInside)
        
        self.view.addSubview(label)
        self.view.addSubview(image)
        self.view.addSubview(button)
    }
    
    @objc func third_dismiss() {
        self.delegate.dismiss_basics_third()
    }
}

