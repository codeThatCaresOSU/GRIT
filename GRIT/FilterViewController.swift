//
//  FilterViewController.swift
//  GRIT
//
//  Created by Jake Alvord on 10/19/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//
import UIKit

protocol FilterViewControllerDelegate {
    func dismiss_filter(categories: Array<String>)
}

class FilterViewController: UIViewController {
    
    var delegate: FilterViewControllerDelegate! = nil
    var fields = Array<String>()
    
    let food_button = UIButton()
    let food_label = UILabel()
    let ged_button = UIButton()
    let ged_label = UILabel()
    let sce_button = UIButton()
    let sce_label = UILabel()
    let recovery_button = UIButton()
    let recovery_label = UILabel()
    let transportation_button = UIButton()
    let transportation_label = UILabel()
    
    override func viewDidLoad() {

        let blur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blur_view = UIVisualEffectView(effect: blur)
        blur_view.frame = view.bounds
        blur_view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        let button_size = self.view.bounds.width/5
        let x_width = self.view.bounds.width/2 - 2 * button_size
        var temp = (self.view.bounds.height - (button_size * 6 + 100))/2
        
        
        // ------------------------------------------------------------------------------------
        // filter additions
        // ------------------------------------------------------------------------------------
        
        let filter_view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        
        // ------------------------------------------------------------------------------------
        
        buttonSetUp(name: "food", sender: food_button, num: 1, x_spot: x_width, y_spot: temp, button_size: button_size, x_width: x_width, but: CGFloat(1), title: food_label)
        
        temp += button_size + 20

        
        // ------------------------------------------------------------------------------------
        
        //let slide_two = UIView(frame: CGRect(x: x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        
        buttonSetUp(name: "ged", sender: ged_button, num: 1, x_spot: x_width, y_spot: temp, button_size: button_size, x_width: x_width, but: CGFloat(4), title: ged_label)
        
         temp += button_size + 20

        
        // ------------------------------------------------------------------------------------
        
        //let slide_three = UIView(frame: CGRect(x: 2 * x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        

        buttonSetUp(name: "second chance employers", sender: sce_button, num: 3, x_spot: x_width, y_spot: temp, button_size: button_size, x_width: x_width, but: CGFloat(2), title: sce_label)
        
         temp += button_size + 20

        
        // ------------------------------------------------------------------------------------
        
        //let slide_four = UIView(frame: CGRect(x: 3 * x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        

        buttonSetUp(name: "recovery", sender: recovery_button, num: 1, x_spot: x_width, y_spot: temp, button_size: button_size, x_width: x_width, but: CGFloat(5), title: recovery_label)
        
         temp += button_size + 20

        
        // ------------------------------------------------------------------------------------
        
        //let slide_five = UIView(frame: CGRect(x: 4 * x_width/5, y: x_spot, width: x_width/5, height: filter_view.bounds.height))
        

        buttonSetUp(name: "transportation", sender: transportation_button, num: 1, x_spot: x_width, y_spot: temp, button_size: button_size, x_width: x_width, but: CGFloat(3), title: transportation_label)
        
        temp += button_size + 20

        
        // adding filter subviews
        
        filter_view.addSubview(food_label)
        filter_view.addSubview(food_button)
        filter_view.addSubview(ged_label)
        filter_view.addSubview(ged_button)
        filter_view.addSubview(sce_label)
        filter_view.addSubview(sce_button)
        filter_view.addSubview(recovery_label)
        filter_view.addSubview(recovery_button)
        filter_view.addSubview(transportation_label)
        filter_view.addSubview(transportation_button)
        
        let filter = UIButton()
        filter.frame = CGRect(x: x_width, y: temp, width: button_size * 4, height: button_size - 20)
        filter.setTitle("Filter", for: .normal)
        filter.backgroundColor = UIColor.blue
        filter.layer.cornerRadius = 10
        filter.addTarget(self, action: #selector(dis(sender:)), for: .touchDown)
        
        filter_view.addSubview(filter)
        
        // ------------------------------------------------------------------------------------
        // subview additions
        // ------------------------------------------------------------------------------------
        
        //self.view.addSubview(subview)
        self.view.addSubview(blur_view)
        self.view.addSubview(filter_view)
        self.view.bringSubview(toFront: filter_view)
        
    }
    
    @objc func dis(sender: UIButton) {
        comp()
        self.delegate.dismiss_filter(categories: fields)
    }
    
    func buttonSetUp(name: String, sender: UIButton, num: Int, x_spot: CGFloat, y_spot: CGFloat, button_size: CGFloat, x_width: CGFloat, but: CGFloat, title: UILabel) {
        
        sender.frame = CGRect(x: x_spot, y: y_spot, width: button_size, height: button_size)
        sender.layer.cornerRadius = button_size/2
        sender.layer.masksToBounds = true
        sender.backgroundColor = colorMaster
        
        var image = UIImage()
        
        if (but == 1) {
            image = #imageLiteral(resourceName: "food.png")
            title.text = "Food"
        } else if (but == 2) {
            image = #imageLiteral(resourceName: "humans.png")
            title.text = "Employers"
        } else if (but == 3) {
            image = #imageLiteral(resourceName: "refresh.png")
            title.text = "Recovery"
        } else if (but == 4) {
            image = #imageLiteral(resourceName: "diploma.png")
            title.text = "GED"
        } else if (but == 5) {
            image = #imageLiteral(resourceName: "bus.png")
            title.text = "Transportation"
        }
        
        sender.setImage(image, for: .normal)
        sender.imageEdgeInsets = UIEdgeInsetsMake(button_size/6,button_size/6,button_size/6,button_size/6)
        
        var size = CGFloat(30)
    
        if button_size > 70 {
            size = 35
        }
        
        title.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
        title.textColor = UIColor.white
        title.textAlignment = .center
        title.sizeToFit()
        title.frame = CGRect(x: x_spot + (4 * button_size)/3, y: y_spot + button_size/4, width: title.bounds.width, height: title.bounds.height)
        
        sender.addTarget(self, action: #selector(button_tapped(sender:)), for: .touchDown)
        
    }
    
    func comp() {
        
        fields.removeAll()
        
        if food_button.backgroundColor == UIColor.lightGray {
            fields.append("Food")
        }
        
        if ged_button.backgroundColor == UIColor.lightGray {
            fields.append("G.E.D.")
        }
        
        if sce_button.backgroundColor == UIColor.lightGray {
            fields.append("Second Chance Employer")
        }
        
        if recovery_button.backgroundColor == UIColor.lightGray {
            fields.append("Recovery")
        }
        
        if transportation_button.backgroundColor == UIColor.lightGray {
            fields.append("Transportation")
        }
        
    }
    
    @objc func button_tapped(sender: UIButton) {
        
        if sender.backgroundColor == colorMaster {
            sender.backgroundColor = UIColor.lightGray

        } else if sender.backgroundColor == UIColor.lightGray {
            sender.backgroundColor = colorMaster
        }
        
    }
    
    
}
