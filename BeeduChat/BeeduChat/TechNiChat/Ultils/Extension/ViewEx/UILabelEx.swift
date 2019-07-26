//
//  UILabelEx.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text : String, textColor : UIColor, font : UIFont?) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font ?? Constant.text.font.normal
    }
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: bounds.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
