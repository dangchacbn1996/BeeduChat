//
//  Constant.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

struct Constant {
    
    struct size {
        static let iconNormal : CGFloat = 32
        static let avatarNormal : CGFloat = 36
        static let naviHeight = Constant.size.iconNormal + Constant.size.padingAround
        static let pading : CGFloat = 16
        static let padingAround = 2 * Constant.size.pading
    }
    
    struct color {
        static let separate = UIColor.gray
        static let naviBack = UIColor.white
    }
    
    struct text {
        struct color {
            static let black = UIColor.black
            static let gray = UIColor.gray
        }
        
        struct font {
            static let small = UIFont.systemFont(ofSize: Constant.text.size.small)
            static let normal = UIFont.systemFont(ofSize: Constant.text.size.normal)
            static let large = UIFont.systemFont(ofSize: Constant.text.size.large)
        }
        
        struct size {
            static let small : CGFloat = 10
            static let normal : CGFloat = 14
            static let large : CGFloat = 16
        }

    }
}