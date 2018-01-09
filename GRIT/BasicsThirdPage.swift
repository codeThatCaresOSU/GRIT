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
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        button.backgroundColor = UIColor.purple
        button.addTarget(self, action: #selector(third_dismiss), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func third_dismiss() {
        self.delegate.dismiss_basics_third()
    }
}

