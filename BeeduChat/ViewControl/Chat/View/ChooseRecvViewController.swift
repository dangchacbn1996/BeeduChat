//
//  ChooseRecvViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class ChooseRecvViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var lblTitle = UILabel()
    var btnBack = UIButton()
    var searchView = UIView()
    var btnSearch = UIButton()
    var txtSearch = UITextField()
    var SendAllView = UIView()
    var lblSendAll = UILabel()
    var tbvSendAll = UITableView()
    var tbvCellSendAll = UITableView()
    var sendGroupView = UIView()
    var lblSendGroup = UILabel()
    var tbvSendGroup = UITableView()
    var tbvCellSendGroup = UITableViewCell()
    var lblAdd = UILabel()
    var sendPrivateView = UIView()
    var lblSendPrivate = UILabel()
    var tbvSendPrivate = UITableView()
    var tbvCellSendPrivate = UITableViewCell()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
}
extension ChooseRecvViewController{
    func setupUI(){
        UINavBar()
        UISearchBar()
        UISendAll()
        UISendGroup()
        UISendPrivate()
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
        lblTitle.text = "Chọn người nhận"
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
            //add button search
            srcView.addSubview(self.btnSearch)
            self.btnSearch.snp.makeConstraints({ (maker) in
                //                maker.left.equalToSuperview()
                maker.height.equalTo(self.btnSearch.snp.width)
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
    func UISendAll(){
        self.view.addSubview(SendAllView)
        SendAllView.snp.makeConstraints { (maker) in
            maker.height.equalTo(56)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(searchView.snp.bottom).offset(16)
            maker.centerX.equalTo(searchView.snp.centerX)
        }
        SendAllView.backgroundColor = UIColor.red
        SendAllView.addSubview(lblSendAll)
        lblSendAll.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblSendAll.text = "Gửi cả lớp"
        lblSendAll.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        SendAllView.addSubview(tbvSendAll)
        tbvSendAll.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblSendAll.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(48)
            maker.width.equalToSuperview()
        }
        
        tbvSendAll.backgroundColor = UIColor.green
        
    }
    func UISendGroup(){
        self.view.addSubview(sendGroupView)
        sendGroupView.snp.makeConstraints { (maker) in
            maker.height.equalTo(56)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(SendAllView.snp.bottom).offset(16)
            maker.centerX.equalTo(SendAllView.snp.centerX)
        }
        sendGroupView.backgroundColor = UIColor.red
        sendGroupView.addSubview(lblSendGroup)
        lblSendGroup.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblSendGroup.text = "Gửi cho nhóm"
        lblSendGroup.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        
        sendGroupView.addSubview(lblAdd)
        lblAdd.snp.makeConstraints { (maker) in
            maker.top.right.equalToSuperview()
        }
        lblAdd.textColor = UIColorFromRGB(rgbValue: 0x4a658d)
        lblAdd.text = "Thêm"
        sendGroupView.addSubview(tbvSendGroup)
        tbvSendGroup.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblSendGroup.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(48)
            maker.width.equalToSuperview()
        }
        
        tbvSendGroup.backgroundColor = UIColor.green
        
    }
    func UISendPrivate(){
        self.view.addSubview(sendPrivateView)
        sendPrivateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(56)
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(sendGroupView.snp.bottom).offset(16)
            maker.centerX.equalTo(sendGroupView.snp.centerX)
        }
        sendPrivateView.backgroundColor = UIColor.red
        sendPrivateView.addSubview(lblSendPrivate)
        lblSendAll.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblSendPrivate.text = "Gửi cá nhân"
        lblSendPrivate.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        SendAllView.addSubview(tbvSendPrivate)
        tbvSendPrivate.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblSendPrivate.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(48)
            maker.width.equalToSuperview()
        }
        
        tbvSendPrivate.backgroundColor = UIColor.green
        
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
