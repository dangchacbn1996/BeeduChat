//
//  UIButtonEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title : String, font : UIFont, titleColor : UIColor, color : UIColor) {
        self.init()
        self.setTitle(title : title, forState: .normal)
        self.setTitleColor(color : titleColor, forState: .normal)
        self.setBackgroundColor(color : color, forState: .normal)
    }
}
