//
//  ContactViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class ContactViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var lblTitle = UILabel()
    var btnBack = UIButton()
    var searchView = UIView()
    var btnSearch = UIButton(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var contentView = UIView()
    var lblContent = UILabel()
    var btnDown = UIButton()
    var lblAdd = UILabel()
    var tbvContent = UITableView()
    var tbvCellContent = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
}
extension ContactViewController{
    func setupUI(){
        UINavBar()
        UISearchBar()
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
        navigationView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.height.equalToSuperview()
            maker.width.equalToSuperview()
        }
        stackView.addArrangedSubview(self.lblTitle)
        lblTitle.snp.makeConstraints { (maker) in
            maker.left.top.bottom.equalToSuperview()
        }
        lblTitle.text = "Danh bạ"
        lblTitle.textColor = UIColorFromRGB(rgbValue: 0x9ca4ab)
        lblTitle.font = lblTitle.font.withSize(40)
        stackView.addArrangedSubview(self.btnBack)
        btnBack.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview()
        }
        self.btnBack.setImage(UIImage(named: "ic_cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnBack.contentMode = .scaleAspectFit
    }
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp_height)
            maker.width.equalTo(navigationView.snp_width)
            maker.top.equalTo(navigationView.snp_bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp_centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: Constant.size.avatarNormal / 2, border: 0, borderColor: UIColor.gray, design: nil)) { (srcView) -> (Void) in
            srcView.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
            //add button search
            srcView.addSubview(self.btnSearch)
            self.btnSearch.snp.makeConstraints({ (maker) in
                //                maker.left.equalToSuperview()
                maker.height.equalTo(self.btnSearch.snp_width)
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(8)
                
            })
            self.btnSearch.backgroundColor = UIColor.red
            //add text field
            srcView.addSubview(self.txtSearch)
            self.txtSearch.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalTo(self.btnSearch.snp.right).offset(8)
                maker.right.equalToSuperview().offset(-8)
            })
            self.txtSearch.placeholder = "Nhập tên, số điện thoại, email"
        }
    }
    func UIContent(){
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.height.equalTo(56)
            maker.width.equalTo(navigationView.snp_width)
            maker.top.equalTo(searchView.snp_bottom).offset(16)
            maker.centerX.equalTo(searchView.snp_centerX)
        }
        contentView.backgroundColor = UIColor.red
        contentView.addSubview(lblContent)
        lblContent.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblContent.text = "Sắp xếp theo tên"
        lblContent.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        contentView.addSubview(btnDown)
        btnDown.snp.makeConstraints { (maker) in
            maker.right.equalTo(lblContent.snp.right)
        }
        self.btnDown.setImage(UIImage(named: "ic_down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnDown.contentMode = .scaleAspectFit
        contentView.addSubview(lblAdd)
        lblAdd.snp.makeConstraints { (maker) in
            maker.top.right.equalToSuperview()
        }
        lblAdd.textColor = UIColorFromRGB(rgbValue: 0x4a658d)
        lblAdd.text = "Thêm"
        contentView.addSubview(tbvContent)
        tbvContent.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblContent.snp_bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(48)
            maker.width.equalToSuperview()
        }
        
        tbvContent.backgroundColor = UIColor.green
        
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
