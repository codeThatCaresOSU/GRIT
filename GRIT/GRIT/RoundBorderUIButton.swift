//
//  RoundBorderUIButton.swift
//  GRIT
//
//  Created by Taha Topiwala on 3/30/17.
//  Copyright © 2017 CodeThatCares. All rights reserved.
//

import UIKit

class RoundBorderUIButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 7.0
    }

}
