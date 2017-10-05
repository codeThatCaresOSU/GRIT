//
//  ResourcesMessage.swift
//  GRIT
//
//  Created by Jake Alvord on 6/1/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

func load_message(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
    
    let message_view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
    
    let message = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
    message.text = "A map of helpful resources to get back on your feet! Tap any filter to get specific locations and tap again to remove them"
    message.textColor = UIColor.black
    message.textAlignment = .center
    message.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.thin)
    message.numberOfLines = 10
    message.layer.cornerRadius = 10
    message.clipsToBounds = true
    message.backgroundColor = successColor
    
    message_view.addSubview(message)
    
    return message_view
    
}
