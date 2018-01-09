//
//  Tutorial.swift
//  GRIT
//
//  Created by Jake Alvord on 11/1/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

protocol TutorialViewControllerDelegate {
    func dismiss_tutorial()
}

class TutorialViewController : UIViewController, BasicsFirstPageDelegate {
    
    var delegate: TutorialViewControllerDelegate! = nil
    
    let basics_first = BasicsFirstPage()
    
    let subview = UIView()
    let skip_tutorial = UIButton()
    
    override func viewDidLoad() {

        self.basics_first.t_delegate = self as BasicsFirstPageDelegate
        
        subview.frame = self.view.bounds
        subview.backgroundColor = UIColor.white
                
        let total_height = subview.bounds.height
        
        let width = subview.bounds.width
        let height = (11 * total_height)/12
        
        let query_space = UIView()
        query_space.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        first_question(view: query_space, width: width, height: height)
        
        skip_tutorial.frame = CGRect(x: 5, y: height + 5, width: width - 10, height: total_height - height - 10)
        skip_tutorial.setTitle("Skip Tutorial", for: .normal)
        skip_tutorial.setTitleColor(UIColor.white, for: .normal)
        skip_tutorial.backgroundColor = UIColor.blue
        skip_tutorial.layer.cornerRadius = 10
        skip_tutorial.layer.masksToBounds = true
        skip_tutorial.addTarget(self, action: #selector(skip), for: .touchUpInside)
                
        subview.addSubview(skip_tutorial)
        subview.addSubview(query_space)
        self.view.addSubview(subview)
    }
    
    func first_question(view: UIView, width: CGFloat, height: CGFloat) {
        
        let part_view = UIView()
        part_view.frame = view.bounds
        
        let question_label = UILabel()
        question_label.frame = CGRect(x: width/16, y: height/8, width: width * (14/16), height: height/4)
        question_label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.thin)
        question_label.numberOfLines = 4
        question_label.text = "How experienced are you with applications / smartphones?"
        question_label.layer.borderColor = successColor.cgColor
        question_label.layer.borderWidth = 4
        question_label.layer.masksToBounds = true
        question_label.layer.cornerRadius = 10
        question_label.textAlignment = .center
        
        let not_at_all = UIButton()
        not_at_all.frame = CGRect(x: width/16, y: height * (7/16), width: width * (14/16), height: height/8)
        not_at_all.backgroundColor = colorMaster
        not_at_all.setTitle("Not At All", for: .normal)
        not_at_all.setTitleColor(UIColor.white, for: .normal)
        not_at_all.layer.cornerRadius = 10
        not_at_all.layer.masksToBounds = true
        not_at_all.addTarget(self, action: #selector(show_basics_first), for: .touchUpInside)
        
        let somewhat = UIButton()
        somewhat.frame = CGRect(x: width/16, y: height * (10/16), width: width * (14/16), height: height/8)
        somewhat.backgroundColor = colorMaster
        somewhat.setTitle("Somewhat", for: .normal)
        somewhat.setTitleColor(UIColor.white, for: .normal)
        somewhat.layer.cornerRadius = 10
        somewhat.layer.masksToBounds = true
        
        let very = UIButton()
        very.frame = CGRect(x: width/16, y: height * (13/16), width: width * (14/16), height: height/8)
        very.backgroundColor = colorMaster
        very.setTitle("Very", for: .normal)
        very.setTitleColor(UIColor.white, for: .normal)
        very.layer.cornerRadius = 10
        very.layer.masksToBounds = true
        very.addTarget(self, action: #selector(skip), for: .touchUpInside)
        
        part_view.addSubview(question_label)
        part_view.addSubview(not_at_all)
        part_view.addSubview(somewhat)
        part_view.addSubview(very)
        view.addSubview(part_view)
    }
    
    @objc func skip() {
        self.delegate.dismiss_tutorial()
    }
    
    @objc func show_basics_first() {
        basics_first.modalPresentationStyle = .overCurrentContext
        self.present(self.basics_first, animated: true, completion: nil)
    }
    
    func dismiss_basics_first() {
        self.basics_first.dismiss(animated: true, completion: nil)
        skip()
    }
    
    
}
