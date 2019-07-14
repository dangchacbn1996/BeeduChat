//
//  NewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewPostViewController : UIViewController {
    
    var userInfoView : UIView!
    
    override func viewDidLoad() {
        setupUI()
    }
    
}

extension NewPostViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
//        self.view.addSubview(UIView()) { (navi) -> (Void) in
//            navi.addSubview(UIButton(title : "Huỷ", font : Constant.font.normal , titleColor : Constant.color.buttonText, color : UIColor.clear), design: { (button) -> (Void) in
//                button.snp.makeConstraint { (maker) -> (Void) in
//                    maker.snp.leading.equalToSuperview().offset(16)
//                    maker.top.bottom.equalToSuperview()
//                }
//            })
//        }
    }
}
