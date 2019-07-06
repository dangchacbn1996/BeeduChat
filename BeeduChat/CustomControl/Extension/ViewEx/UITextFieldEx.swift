//
//  UITextFieldEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UITextField {
    convenience init(text : String, textColor : UIColor, font : UIFont?) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font ?? Constant.text.font.normal
    }
}
