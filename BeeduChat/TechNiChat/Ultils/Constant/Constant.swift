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
        static let btnIcon : CGFloat = 24
        static let avatarNormal : CGFloat = 36
        static let avatarSmall : CGFloat = 24
        static let naviHeight = UIApplication.shared.statusBarFrame.height + btnIcon + 2 * Constant.size.padding
        static let padding : CGFloat = 8
        static let avatarBig : CGFloat = 64
        static let rowHeightChat : CGFloat = 77
        static let separatorHeight : CGFloat = 0.5
    }
    
    struct color {
        static let postBack = UIColor.white
        static let separate = UIColor(red: 139/255, green: 148/255, blue: 159/255, alpha: 1.0)
        static let separateNewFeed = UIColor(144,164,174)
        static let naviBack = UIColor.white
        static let iconColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
        static let btnTitle = UIColor(68, 138, 255)
        static let commentBack = UIColor(238,238,238)
    }
    
    struct text {
        struct color {
            static let black = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1.0)
            //139,148,159
            static let gray = UIColor(red: 139/255, green: 148/255, blue: 159/255, alpha: 1.0)
        }
        
        struct font {
//            static let small = UIFont.systemFont(ofSize: Constant.text.size.small)
            static let small = UIFont(name: "Helvetica", size: Constant.text.size.small)!
            static let normal = UIFont(name: "Helvetica", size: Constant.text.size.normal)!
            static let large = UIFont(name: "Helvetica", size: Constant.text.size.large)!
            static func customFont(size : CGFloat, weight : Constant.text.font.weight) -> (UIFont) {
                return UIFont(name: "Helvetica-\(weight.rawValue)", size: size) ?? UIFont(name: "Helvetica", size: size)!
            }
            enum weight : String {
                case Regular = "Regular"
                case Bold = "Bold"
                case Bold_Italic = "Bold Italic"
                case Condensed_Black = "Condensed Black"
                case Condensed_Bold = "Condensed Bold"
                case Italic = "Italic"
                case Light_Italic = "Light Italic"
                case Medium = "Medium"
                case Medium_Italic = "Medium Italic"
                case Thin = "Thin"
                case Thin_Italic = "Thin Italic"
                case UltraLight = "UltraLight"
                case UltraLight_Italic = "UltraLight Italic"
            }
        }
        
        struct size {
            static let small : CGFloat = 12
            static let normal : CGFloat = 14
            static let large : CGFloat = 16
        }

    }
    
    static func rightToLeftTrans() -> (CATransition){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        return transition
    }
    
    static func backLeftToRight() -> (CATransition){
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        
        return transition
    }
    
    static func animationTo(view : UIViewController, type : AnimationType){
        switch type {
        case .push:
            view.view.window!.layer.add(Constant.rightToLeftTrans(), forKey: nil)
        case .dismiss:
            view.view.window!.layer.add(Constant.backLeftToRight(), forKey: nil)
        default:
            return
        }
    }
}

enum AnimationType {
    case push
    case dismiss
}