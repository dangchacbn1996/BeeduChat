//
//  ViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/5/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var viewContainer = UIView()
    var viewIcon = UIView()
    var listButton : [UIButton] = []
    let iconSize = 38
    let iconResize = 30
    let space = 4
    var normalCenter : [CGPoint] = []
    var resizeCenter : [CGPoint] = []
    let incCenter : CGFloat = 12
    var current = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalCenter = []
        for index in 0..<6 {
            var center = space + (space + iconSize) * index
            center += iconSize / 2
            normalCenter.append(CGPoint(x: center, y: iconSize * 3 / 2))
        }
        resizeCenter = []
        for index in 0..<6 {
            var center = space + (space + iconResize) * index
            center += iconResize / 2
            resizeCenter.append(CGPoint(x: center, y: iconSize * 2 - iconResize / 2))
        }
        
        viewContainer = UIView()
        viewContainer.backgroundColor = .clear
        viewContainer.frame = CGRect(x: 100, y: 200, width: 272, height: 4 + iconSize * 2)
        self.view.addSubview(viewContainer)
        viewIcon = UIView()
        viewIcon.backgroundColor = UIColor.white
        self.viewContainer.addSubview(viewIcon)
        viewIcon.frame = CGRect(x: 0, y: iconSize - 4, width: 256, height: iconSize + 8)
        viewIcon.clipsToBounds = true
        viewIcon.layer.cornerRadius = 46 / 2
        listButton = []
        for index in 0..<6 {
            let btn = UIButton()
            btn.center = normalCenter[index]
            btn.frame = CGRect(x: Int(normalCenter[index].x) - iconSize / 2, y: Int(normalCenter[index].y) - iconSize / 2, width: iconSize, height: iconSize)
            btn.setImage(UIImage(named: "emoji_like"), for: .normal)
            btn.tag = index
//            btn.addTarget(self, action: #selector(dragEnter(_:)), for: .)
            listButton.append(btn)
            viewContainer.addSubview(listButton[index])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        <#code#>
    }
    
    @objc func dragEnter(_ sender: UIButton) {
        zoomItem(tag: sender.tag)
    }
    
    
    func zoomItem(tag : Int) {
        for index in 0..<listButton.count {
            var x : Int = 0
            var y : Int = 0
            var size : Int = iconResize
            if (tag < index) {
                x = Int(resizeCenter[index].x + CGFloat(listButton.count * (iconSize - iconResize)))
            } else if tag > index {
                x = Int(resizeCenter[index].x)
            } else {
                x = Int(resizeCenter[index].x + CGFloat(iconSize * 2 - iconResize) / 2)
            }
            if (tag == index) {
                y = iconSize
                size = iconSize * 2
            } else {
                y = Int(resizeCenter[index].y)
                size = iconResize
            }
            listButton[index].frame = CGRect(x: x - size / 2, y: y - size / 2, width: size, height: size)
        }
        
//        if (tag == btn1.tag) {
//            btn1.center = CGPoint(x: resizeCenter[0].x + incCenter, y: resizeCenter[0].y)
//            btn1.frame.size = CGSize(width: iconSize * 2, height: iconSize * 2)
//        } else {
//            btn1.center = resizeCenter[0]
//            btn1.frame.size = CGSize(width: iconResize, height: iconResize)
//        }
//
//        if (tag == btn2.tag) {
//            btn2.center = CGPoint(x: resizeCenter[1].x + incCenter, y: resizeCenter[1].y)
//            btn2.frame.size = CGSize(width: iconSize * 2, height: iconSize * 2)
//        } else {
//            if (tag < btn2.tag) {
//                btn2.center = resizeCenter[0]
//            }  else {
//                btn2.center
//            }
//            btn2.frame.size = CGSize(width: iconResize, height: iconResize)
//        }
//
//        if (tag == btn3.tag) {
//            btn3.center = CGPoint(x: resizeCenter[2].x + incCenter, y: resizeCenter[2].y)
//            btn3.frame.size = CGSize(width: iconSize * 2, height: iconSize * 2)
//        } else {
//            btn3.center = resizeCenter[0]
//            btn3.frame.size = CGSize(width: iconResize, height: iconResize)
//        }
//
//        if (tag == btn4.tag) {
//            btn4.center = CGPoint(x: resizeCenter[3].x + incCenter, y: resizeCenter[3].y)
//            btn4.frame.size = CGSize(width: iconSize * 2, height: iconSize * 2)
//        } else {
//            btn4.center = resizeCenter[0]
//            btn4.frame.size = CGSize(width: iconResize, height: iconResize)
//        }
//
//        if (tag == btn5.tag) {
//            btn5.center = CGPoint(x: resizeCenter[4].x + incCenter, y: resizeCenter[4].y)
//            btn5.frame.size = CGSize(width: iconSize * 2, height: iconSize * 2)
//        } else {
//            btn5.center = resizeCenter[0]
//            btn5.frame.size = CGSize(width: iconResize, height: iconResize)
//        }
//
//        if (tag == btn6.tag) {
//            btn6.center = CGPoint(x: resizeCenter[5].x + incCenter, y: resizeCenter[5].y)
//            btn6.frame.size = CGSize(width: iconSize * 2, height: iconSize * 2)
//        } else {
//            btn6.center = resizeCenter[0]
//            btn6.frame.size = CGSize(width: iconResize, height: iconResize)
//        }
    }
}

