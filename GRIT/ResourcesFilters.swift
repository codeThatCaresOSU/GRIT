//
//  ResourcesFilters.swift
//  GRIT
//
//  Created by Jake Alvord on 6/1/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

func load_filter(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
    
    let filter_view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
    
    let food_button = load_buttons(x: 0, y: 0, width: width/3, height: height/2, name: "Food")
    let employers_button = load_buttons(x: width/6, y: height/2, width: width/3, height: height/2, name: "Employers")
    let recovery_button = load_buttons(x: width/3, y: 0, width: width/3, height: height/2, name: "Recovery")
    let ged_button = load_buttons(x: width/2, y: height/2, width: width/3, height: height/2, name: "GED")
    let transport_button = load_buttons(x: (2 * width)/3, y: 0, width: width/3, height: height/2, name: "Transportation")
    
    filter_view.addSubview(food_button)
    filter_view.addSubview(employers_button)
    filter_view.addSubview(recovery_button)
    filter_view.addSubview(ged_button)
    filter_view.addSubview(transport_button)
    
    return filter_view
    
}

func load_buttons(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, name: String) -> UIView {
    
    let portion = UIView(frame: CGRect(x: x,  y: y, width: width, height: height))
    
    let button_height = (5 * height)/6
    
    var size = width
    if width > button_height {
        size = button_height
    }
    
    let shift = (width - size)/2
    
    let button = UIButton(frame: CGRect(x: shift, y: 0, width: size, height: size))
    button.layer.cornerRadius = size/2
    button.backgroundColor = colorMaster
    
    switch name {
        case "Food":
            button.setImage(#imageLiteral(resourceName: "food.png"), for: .normal)
            button.setTitle("Food", for: .normal)
        case "Employers":
            button.setImage(#imageLiteral(resourceName: "humans.png"), for: .normal)
            button.setTitle("Employers", for: .normal)
        case "Recovery":
            button.setImage(#imageLiteral(resourceName: "refresh.png"), for: .normal)
            button.setTitle("Recovery", for: .normal)
        case "GED":
            button.setImage(#imageLiteral(resourceName: "diploma.png"), for: .normal)
            button.setTitle("GED", for: .normal)
        case "Transportation":
            button.setImage(#imageLiteral(resourceName: "bus.png"), for: .normal)
            button.setTitle("Transportation", for: .normal)
        default:
            button.setImage(#imageLiteral(resourceName: "refresh.png"), for: .normal)
    }
    
    
    button.imageEdgeInsets = UIEdgeInsetsMake(size/6, size/6, size/6, size/6)
    button.addTarget(ResourcesViewController(), action: #selector(ResourcesViewController.button_tapped(sender:)), for: .touchUpInside)
    
    let label_view = UIView(frame: CGRect(x: 0, y: (5 * height)/6, width: width, height: height/6))
    
    let label = UILabel()
    label.text = name
    label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightThin)
    label.sizeToFit()
    label.textAlignment = .center
    
    let label_center = (width - label.bounds.width)/2
    
    label.frame = CGRect(x: label_center, y: 0, width: label.bounds.width, height: height/6)
    
    label_view.addSubview(label)
    
    portion.addSubview(button)
    portion.addSubview(label_view)
    
    return portion
    
}
