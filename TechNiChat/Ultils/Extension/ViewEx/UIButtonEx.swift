//
//  UIButtonEx.swift
//  BeeduChat
//
//  Created by ChacND_HAV on 7/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(title : String, font : UIFont, titleColor : UIColor, backColor : UIColor, action : UITapGestureRecognizer?) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backColor
        if (action != nil) {
            addGestureRecognizer(action!)
        }
    }
}
