//
//  UIColorEx.swift
//  BeeduChat
//

//  Created by ChacND_HAV on 7/11/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}
