//
//  TNBaseViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/23/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class TNBaseViewController : UIViewController {
    var naviBtnLeft = UIButton()
    var naviBtnRight : UIButton?
    var naviBtnRightFunc : UIButton?
    var naviLbTitle : UILabel?
    var naviViewCenter : UIView?
    var navigation = UIView()
    var naviSeparate = UIView()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
    }
    
    func setNavigation(image : UIImage?, leftAction : UITapGestureRecognizer?){
        self.view.addSubview(navigation)
        navigation.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalTo(Constant.size.naviHeight)
        }
        navigation.backgroundColor = Constant.color.naviBack
        
        let naviContent = UIView()
        navigation.addSubview(naviContent)
        naviContent.backgroundColor = .clear
        naviContent.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            maker.left.right.bottom.equalToSuperview()
        }
        naviContent.addSubview(naviBtnLeft)
        naviBtnLeft.setImage(image, for: .normal)
        naviBtnLeft.imageView?.contentMode = .scaleAspectFit
        naviBtnLeft.tintColor = Constant.color.iconColor
        if (leftAction != nil) {
            naviBtnLeft.addGestureRecognizer(leftAction!)
        }
        naviBtnLeft.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(Constant.size.paddingView)
            maker.centerY.equalToSuperview()
            maker.height.width.equalTo(Constant.size.btnIcon)
        }
        
        if (naviBtnRight != nil) {
            naviBtnRight?.imageView?.contentMode = .scaleAspectFit
            naviBtnRight?.tintColor = Constant.color.iconColor
            naviContent.addSubview(naviBtnRight!)
            naviBtnRight!.snp.makeConstraints({ (maker) in
                maker.right.equalToSuperview().offset(-Constant.size.paddingView)
                maker.centerY.equalToSuperview()
                maker.height.width.equalTo(Constant.size.btnIcon)
            })
        }
        
        if (naviBtnRightFunc != nil) {
            naviBtnRightFunc?.imageView?.contentMode = .scaleAspectFit
            naviBtnRightFunc?.tintColor = Constant.color.iconColor
            naviContent.addSubview(naviBtnRightFunc!)
            naviBtnRightFunc!.snp.makeConstraints({ (maker) in
                maker.right.equalTo(naviBtnRight?.snp.left ?? navigation.snp.right).offset(-Constant.size.padding)
                maker.centerY.equalToSuperview()
                maker.height.width.equalTo(Constant.size.btnIcon)
            })
        }
        
        if (naviLbTitle != nil) {
            naviContent.addSubview(naviLbTitle!)
            naviLbTitle!.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
            }
        }
        
        if (naviViewCenter != nil) {
            naviContent.addSubview(naviViewCenter!)
            naviViewCenter!.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
                maker.height.lessThanOrEqualToSuperview()
                maker.left.greaterThanOrEqualTo(naviBtnLeft.snp.right).offset(Constant.size.padding)
                maker.right.lessThanOrEqualToSuperview().offset(-Constant.size.padding)
            }
        }
        
        navigation.addSubview(naviSeparate)
        naviSeparate.alpha = 0
        naviSeparate.backgroundColor = Constant.color.separate
        naviSeparate.snp.makeConstraints { (maker) in
            maker.centerX.width.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-Constant.size.separatorHeight)
            maker.height.equalTo(Constant.size.separatorHeight)
        }
    }
}
