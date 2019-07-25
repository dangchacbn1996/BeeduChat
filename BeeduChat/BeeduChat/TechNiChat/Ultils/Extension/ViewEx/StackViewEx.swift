//
//  StackViewEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(axis : NSLayoutConstraint.Axis, distribution : UIStackView.Distribution, alignment : UIStackView.Alignment, spacing : CGFloat, design : ((UIStackView) -> Void)?) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        design?(self)
    }
    
    func addArrangedSubview(_ view : UIView, design : ((UIView) -> (Void))?) {
        self.addArrangedSubview(view)
        design?(view)
    }
}
