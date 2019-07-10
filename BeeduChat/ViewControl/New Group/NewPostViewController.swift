//
//  NewPostViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit

class NewPostViewController : UIViewController {
    
    var userInfoView : UIView!
    
    override func viewDidLoad() {
        setupUI()
    }
    
}

extension NewPostViewController {
    func setupUI(){
        self.view.backgroundColor = Constant.color.naviBack
        self.view.addSubview(UIView()) { (navi) -> (Void) in
            navi.addSubview(UIButton(), design: <#T##((UIView) -> (Void))?##((UIView) -> (Void))?##(UIView) -> (Void)#>)
        }
    }
}
