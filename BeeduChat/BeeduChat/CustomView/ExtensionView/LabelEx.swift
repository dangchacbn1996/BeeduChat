//
//  LabelEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UILabel{
    convenience init(text : String, font : UIFont, textColor : UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
