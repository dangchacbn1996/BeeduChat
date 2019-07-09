//
//  DetailMessViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/8/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class DetailMessViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var stackviewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil)
    var btnMenu = UIButton()
    var lblClass = UILabel(text: "Đã đọc", textColor: Constant.text.color.black, font: nil)
    var lblSubClass = UILabel(text: "Có 2 người xem", textColor: Constant.text.color.gray, font: nil)
    var contentView = UIView()
    var tbvContent = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        // Do any additional setup after loading the view.
    }

}

extension DetailMessViewController{
    func SetupUI(){
        UINavBar()
        UIContent()
    }
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().offset(-32)
            maker.height.equalTo(40)
        }
        //        navigationView.backgroundColor = UIColor.blue
        // add stack view to navigationView
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        //add button menu to stackView
        stackView.addArrangedSubview(self.btnMenu)
        btnMenu.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnMenu.snp_width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        self.btnMenu.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnMenu.contentMode = .scaleAspectFit
        //        btnMenu.backgroundColor = UIColor.blue
        //add stackview Tittle lalbe
        stackView.addArrangedSubview(stackviewTitle)
        stackviewTitle.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().multipliedBy(1)
        }
        //add lable class name
        stackviewTitle.addArrangedSubview(lblClass)
        stackviewTitle.addArrangedSubview(lblSubClass)
    }
    func UIContent(){
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalTo(navigationView.snp_width)
            maker.top.equalTo(navigationView.snp_bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp_centerX)
        }
        contentView.addSubview(tbvContent)
        tbvContent.snp.makeConstraints { (maker) in
            maker.height.width.centerX.equalToSuperview()
        }
        tbvContent.backgroundColor = UIColor.blue
    }
}
