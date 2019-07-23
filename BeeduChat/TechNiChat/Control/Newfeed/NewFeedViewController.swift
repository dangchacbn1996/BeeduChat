//
//  NewFeedViewController.swift
//  BeeduChat
//
//  Created by Ngo Dang Chac on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewFeedViewController: UIViewController {
    
    var btnMenu = UIButton()
    var lbClass = UILabel(text: "Lớp Fox", textColor: Constant.text.color.black, font: nil)
    var lbSubClass = UILabel(text: "@fox.class", textColor: Constant.text.color.black, font: nil)
    
    var navigationView = UIView(background: UIColor.white, corner: 0, border: 0, borderColor: UIColor.gray, design: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension NewFeedViewController{
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(navigationView)
        navigationView.dropShadow(scale : true)
//        navigationView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            maker.height.equalTo(48)
        }
        
        navigationView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8, design: nil)) { (stackNavi) -> (Void) in
            stackNavi.snp.makeConstraints({ (maker) in
                maker.center.height.equalToSuperview()
                maker.width.equalToSuperview().offset(-16)
            })
            
            //Btn menu
            (stackNavi as! UIStackView).addArrangedSubview(self.btnMenu)
            self.btnMenu.snp.makeConstraints({ (maker) in
                maker.height.equalTo(self.btnMenu.snp_width)
                maker.height.equalToSuperview().multipliedBy(0.8)
            })
            self.btnMenu.backgroundColor = UIColor.blue
            
            //Ten lop
            (stackNavi as! UIStackView).addArrangedSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil), design: { (stackClass) -> (Void) in
                stackClass.snp.makeConstraints({ (maker) in
                    maker.height.equalToSuperview().multipliedBy(1)
                })
                (stackClass as! UIStackView).addArrangedSubview(self.lbClass)
                (stackClass as! UIStackView).addArrangedSubview(self.lbSubClass)
            })
        }
    }
}
