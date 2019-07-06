//
//  UIViewEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIView {
    
    convenience init(background : UIColor, corner : CGFloat, border : CGFloat, borderColor : UIColor?, design : ((UIView) -> (Void))?) {
        self.init()
        self.backgroundColor = background
//        self.clipToBounds = true
    }
    
    func addSubview(_ view : UIView, design : ((UIView) -> (Void))?) {
        self.addSubview(view)
        design?(view)
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
