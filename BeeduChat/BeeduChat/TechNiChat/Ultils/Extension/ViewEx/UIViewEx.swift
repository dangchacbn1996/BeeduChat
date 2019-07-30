//
//  UIViewEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    convenience init(background : UIColor, height : CGFloat?, ratioHW : CGFloat?, corner : CGFloat, border : CGFloat, borderColor : UIColor?, design : ((UIView) -> (Void))?) {
        self.init()
        self.backgroundColor = background
        self.clipsToBounds = true
        self.layer.cornerRadius = corner
        self.layer.borderWidth = border
        self.layer.borderColor = borderColor?.cgColor
        self.snp.makeConstraints { (maker) in
            if (height != nil) {
                maker.height.equalTo(height!)
            }
            if (ratioHW != nil) {
                maker.width.equalTo(self.snp.height).multipliedBy(ratioHW!)
            }
        }
        design?(self)
//        self.clipToBounds = true
    }
    
    convenience init(background: UIColor, corner: CGFloat, border: CGFloat, borderColor: UIColor?, design: ((UIView) -> (Void))?) {
        self.init()
        self.backgroundColor = background
        self.clipsToBounds = true
        self.layer.cornerRadius = corner
        self.layer.borderWidth = border
        self.layer.borderColor = borderColor?.cgColor
        design?(self)
    }
    
    func addSubview(_ view : UIView, design : ((UIView) -> (Void))?) {
        self.addSubview(view)
        design?(view)
    }
    
    func dropShadow(){
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
//        layer.shadowRadius = radius
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
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}
