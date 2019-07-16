//
//  NewGroupViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class NewGroupViewController: UIViewController {

    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var btnBack = UIButton()
    var lblTitle = UILabel(text: "Tạo nhóm", textColor: Constant.text.color.black, font: nil)
    var btnSave = UIButton()
    var searchView = UIView()
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var contactView = UIView()
    var lblMember = UILabel(text: "Chọn", textColor: .black, font: nil)
    var contenView = UIView()
    var tbvContentView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}

extension NewGroupViewController{
    func setupUI(){
        
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
        stackView.addArrangedSubview(self.btnBack)
        btnBack.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnBack.snp.width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        self.btnBack.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnBack.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(lblTitle)
        lblTitle.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().multipliedBy(1)
        }
        stackView.addArrangedSubview(btnSave)
        btnSave.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnSave.snp.width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp.height)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(navigationView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: Constant.size.avatarNormal / 2, border: 0, borderColor: UIColor.gray, design: nil)) { (srcView) -> (Void) in
            srcView.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
            srcView.addSubview(self.txtSearch)
            self.txtSearch.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalTo(self.txtSearch.snp.right).offset(8)
                maker.right.equalToSuperview().offset(-8)
            })
            self.txtSearch.placeholder = "Nhập tên, số điện thoại, email"
        }
    }
    func UIContactView(){
        self.view.addSubview(contactView)
        contactView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
            maker.top.equalTo(searchView.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        contactView.backgroundColor = UIColor.yellow
    }
    func UIContentView(){
        self.view.addSubview(contenView)
        contenView.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
            maker.top.equalTo(contactView.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        contenView.addSubview(lblMember)
        lblMember.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        contenView.addSubview(tbvContentView)
        tbvContentView.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblMember.snp.bottom)
            maker.left.equalToSuperview()
            maker.height.equalTo(48)
            maker.width.equalToSuperview()
        }
        tbvContentView.backgroundColor = UIColor.green
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
