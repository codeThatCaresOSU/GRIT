//
//  BasicsFirstPage.swift
//  GRIT
//
//  Created by Jake Alvord on 12/7/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

protocol BasicsFirstPageDelegate {
    func dismiss_basics_first()
}

class BasicsFirstPage : UIViewController {

    var delegate: BasicsFirstPageDelegate! = nil
    
    override func viewDidLoad() {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(first_dismiss), for: .touchUpInside)
        self.view.addSubview(button)
    }   

    @objc func first_dismiss() {
        self.delegate.dismiss_basics_first()
    }
}
