//
//  ViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/5/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

protocol PopupEmojiDelegate {
    func selectPos(_ emoji : TNEmoji, indexPath : IndexPath)
}

class TNPopupChooseEmotionViewController: TNBaseViewController {
    
    private var viewContainer = UIView()
    private var viewIcon = UIView()
    private var listButton : [UIButton] = []
    private var listEmoji = [TNEmoji.like, .haha, .wow, .cry, .angry, .heart]
    private var containerSize = CGSize(width: 0, height: 0)
    private let iconSize = 38
    private let iconResize = 30
    private let space = 4
    private var normalCenter : [CGPoint] = []
    private var resizeCenter : [CGPoint] = []
    private let incCenter : CGFloat = 12
    private var current = -1
    var origin : CGPoint = CGPoint()
    var indexPath : IndexPath = IndexPath(row: 0, section: 0)
    var delegate : PopupEmojiDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerSize = CGSize(width: 272, height: 4 + iconSize * 2)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewContainer.frame.origin = CGPoint(x: origin.x, y: origin.y - CGFloat(1 + iconSize * 3 / 2))
        if (origin.y < Constant.size.naviHeight + CGFloat(iconSize * 2) + 40) {
            UIView.animate(withDuration: 0.2) {
                self.viewContainer.frame.origin = CGPoint(x: 16, y: (self.origin.y + 16))
                self.viewContainer.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.viewContainer.frame.origin = CGPoint(x: 16, y: (self.origin.y - CGFloat(20 + 2 * self.iconSize) - Constant.text.font.normal.lineHeight))
                self.viewContainer.alpha = 1
            }
        }
    }
    
    @objc func goBack(){
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let first = touches.first {
            let pos = first.location(in: self.view)
            if viewContainer.frame.contains(pos) {
                let inPos = first.location(in: viewContainer)
                for index in 0..<listButton.count {
                    if (listButton[index].frame.contains(inPos)) {
                        zoomItem(tag: index)
                        break
                    }
                }
            } else {
                zoomItem(tag: -1)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let first = touches.first {
            let pos = first.location(in: self.view)
            if viewContainer.frame.contains(pos) {
                let inPos = first.location(in: viewContainer)
                for index in 0..<listButton.count {
                    if (listButton[index].frame.contains(inPos)) {
                        delegate?.selectPos(listEmoji[index], indexPath: self.indexPath)
                        goBack()
                        return
                    }
                }
            } else {
                goBack()
            }
        }
    }
    
    @objc func dragEnter(_ sender: UIButton) {
        zoomItem(tag: sender.tag)
    }
    
    func zoomItem(tag : Int) {
        if (tag == -1) {
            UIView.animate(withDuration: 0.1) {
                self.viewIcon.frame = CGRect(x: 0, y: self.iconSize - 4, width: 256, height: self.iconSize + 8)
                self.viewIcon.layer.cornerRadius = self.viewIcon.frame.height / 2
            }
            for index in 0..<listButton.count {
                UIView.animate(withDuration: 0.1) {
                    self.listButton[index].frame = CGRect(x: Int(self.normalCenter[index].x) - self.iconSize / 2, y: Int(self.normalCenter[index].y) - self.iconSize / 2, width: self.iconSize, height: self.iconSize)
                }
            }
            return
        }
        UIView.animate(withDuration: 0.1) {
            self.viewIcon.frame = CGRect(x: 0, y: self.iconSize * 2 - self.iconResize - 4, width: 256, height: self.iconResize + 8)
            self.viewIcon.layer.cornerRadius = self.viewIcon.frame.height / 2
        }
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
            UIView.animate(withDuration: 0.1) {
                self.listButton[index].frame = CGRect(x: x - size / 2, y: y - size / 2, width: size, height: size)
            }
        }
    }
}

extension TNPopupChooseEmotionViewController {
    func setupUI(){
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
        viewContainer.dropShadow()
        viewContainer.alpha = 0
        viewContainer.backgroundColor = .clear
        viewContainer.frame = CGRect(x: 0, y: 0, width: 272, height: 4 + iconSize * 2)
        self.view.addSubview(viewContainer)
        viewIcon = UIView()
        viewIcon.backgroundColor = UIColor.white
        self.viewContainer.addSubview(viewIcon)
        viewIcon.frame = CGRect(x: 0, y: iconSize - 4, width: 256, height: iconSize + 8)
        viewIcon.layer.borderColor = UIColor.gray.cgColor
        viewIcon.layer.borderWidth = 0.3
        viewIcon.clipsToBounds = true
        viewIcon.layer.cornerRadius = 46 / 2
        listButton = []
        for index in 0..<listEmoji.count {
            let btn = UIButton()
            btn.center = normalCenter[index]
            btn.frame = CGRect(x: Int(normalCenter[index].x) - iconSize / 2, y: Int(normalCenter[index].y) - iconSize / 2, width: iconSize, height: iconSize)
            
            btn.setImage(UIImage(named: listEmoji[index].rawValue), for: .normal)
            btn.tag = index
            btn.isUserInteractionEnabled = false
            listButton.append(btn)
            viewContainer.addSubview(listButton[index])
        }
    }
}

