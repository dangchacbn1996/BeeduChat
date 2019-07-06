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
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var stackViewTitle = UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil)
    var btnMenu = UIButton()
    var lblClass = UILabel(text: "Lớp Bambi", textColor: Constant.text.color.black, font: nil)
    var lblSubClass = UILabel(text: "@bambi05", textColor: Constant.text.color.gray, font: nil)
    var btnContact = UIButton()
    var btnOption = UIButton()
    var searchView = UIView()
    var btnSearch = UIButton(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var ceparateView = UIView()
    var historyView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        // Do any additional setup after loading the view.
    }

}
extension ChatViewController{
    func setupUI() {
        UINavBar()
        addCeparate()
        UISearchBar()
        UIHisContactBar()
    }
    //NavBar
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.view.safeAreaLayoutGuide)
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().offset(-32)
            maker.height.equalTo(48)
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
        btnMenu.backgroundColor = UIColor.blue
        //add stackviewTitiale
        stackView.addArrangedSubview(stackViewTitle)
        stackViewTitle.snp.makeConstraints { (maker) in
            maker.height.equalToSuperview().multipliedBy(1)
        }
        //add lable class name
        stackViewTitle.addArrangedSubview(lblClass)
        stackViewTitle.addArrangedSubview(lblSubClass)
        //add button contact
        stackView.addArrangedSubview(btnContact)
        btnContact.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnContact.snp_width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        btnContact.backgroundColor = UIColor.orange
        //add button Option
        stackView.addArrangedSubview(btnOption)
        btnOption.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnOption.snp_width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        btnOption.backgroundColor = UIColor.green
        //add ceparate
    }
    func addCeparate(){
        self.view.addSubview(ceparateView)
        ceparateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.width.equalToSuperview()
            maker.top.equalTo(navigationView.snp_bottom).offset(16)
            maker.centerX.equalToSuperview()
        }
        ceparateView.backgroundColor = UIColorFromRGB(rgbValue: 0x363636)
    }    //SearchBar
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp_height)
            maker.width.equalTo(navigationView.snp_width)
            maker.top.equalTo(ceparateView.snp_bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp_centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: 60, border: 1, borderColor: UIColor.gray, design: nil)) { (srcView) -> (Void) in
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
            self.txtSearch.placeholder = "Tìm kiếm"
        }
    }
    func UIHisContactBar(){
        self.view.addSubview(historyView)
        historyView.snp.makeConstraints { (maker) in
            maker.height.equalTo(searchView.snp_height)
            maker.width.equalTo(searchView.snp_width)
            maker.top.equalTo(searchView.snp_bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp_centerX)
        }
//        historyView.backgroundColor = UIColor.red
        historyView.addSubview(UITableView(background: UIColor.red, corner: 0, border: 0, borderColor: .clear, design: nil)) { (tbvHistory) -> (Void) in
            tbvHistory.snp.makeConstraints({ (maker) in
                maker.height.equalTo(4)
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
        }
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
