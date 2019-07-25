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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(UILabel(text: "Adc", textColor: UIColor.blue, font: nil)) { (label) -> (Void) in
            label.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
            })
        }
        
    }
    
}

