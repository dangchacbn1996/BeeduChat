//
//  UIColorEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}
