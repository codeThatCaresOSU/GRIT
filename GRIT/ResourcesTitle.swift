//
//  ResourcesTitle.swift
//  GRIT
//
//  Created by Jake Alvord on 6/1/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

func load_title(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
    
    let title_view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
    
    let title = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
    title.text = "Resources"
    title.textColor = UIColor.black
    title.textAlignment = .center
    title.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.thin)
    
    title_view.addSubview(title)
    
    return title_view
    
}
