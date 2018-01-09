//
//  BasicsSecondPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

protocol BasicsSecondPageDelegate {
    func dismiss_basics_second()
}

class BasicsSecondPage : UIViewController {
    
    var delegate: BasicsSecondPageDelegate! = nil
    
    override func viewDidLoad() {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(second_dismiss), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func second_dismiss() {
        self.delegate.dismiss_basics_second()
    }
}

