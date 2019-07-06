//
//  ChatViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/6/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    //khoi tao cac thanh phan giao dien
    var navigationView = UIView();
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 1, design: nil)
    var menuButtonView = UIView();
    var mainTitleView = UIView();
    var subTitleView = UIView();
    var contactView = UIView();
    var detailView = UIView();
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        // Do any additional setup after loading the view.
    }

}
extension ChatViewController{
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.right.left.equalTo(self.view.safeAreaLayoutGuide)
            maker.height.equalTo(48)
        }
        navigationView.backgroundColor = UIColor.blue
        // add stack view to navigationView
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.top.right.bottom.left.equalToSuperview()
        }
        //add menuView to stackView
        stackView.addArrangedSubview(menuButtonView)
        menuButtonView.snp.makeConstraints { (maker) in
            maker.height.equalTo(menuButtonView.snp_width)
        }
        //add mainTitle to stackView
        stackView.addArrangedSubview(mainTitleView)
//        mainTitleView.snp.makeConstraints { (maker) in
//            <#code#>
//        }
    }
}
