//
//  CreateGroupViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNCreateGroupViewController: UIViewController {
    var naviConstraint : NSLayoutConstraint!
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5, design: nil)
    var btnBack = UIButton()
    var lblTitle = UILabel(text: "Tạo nhóm", textColor: Constant.text.color.black, font: nil)
    var btnSave = UILabel(text: "Lưu", textColor: UIColor.blue, font: nil)
    var searchView = UIView()
    var ceparateView = UIView()
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var lblMember = UILabel(text: "Chọn", textColor: .black, font: nil)
    var contenView = UIView()
    var tbvContentView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        tbvContentView.register(TNCreateGroupCell.self, forCellReuseIdentifier: TNCreateGroupCell.identify)
        tbvContentView.tableFooterView = UIView()
        tbvContentView.tableHeaderView = UIView()
        tbvContentView.separatorStyle = .singleLine
        tbvContentView.delegate = self
        tbvContentView.dataSource = self
    }
}
extension TNCreateGroupViewController{
    func setupUI(){
        UINavBar()
        addCeparate()
        UISearchBar()
        UIContentView()
    }
    func UINavBar(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(navigationView)
        //        navigationView.dropShadow(scale : true)
        //        navigationView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        navigationView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            maker.width.equalToSuperview()
            //            maker.height.equalTo(Constant.size.naviHeight)
        }
        naviConstraint = navigationView.heightAnchor.constraint(equalToConstant: Constant.size.naviHeight)
        naviConstraint.isActive = true
        /* Navigation
         **************************************
         * Menu         Class       noti more *
         **************************************
         */
        navigationView.addSubview(UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 4, design: nil)) { (stackNavi) -> (Void) in
            stackNavi.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.height.equalToSuperview().offset(-2 * Constant.size.padding)
                maker.width.equalToSuperview().offset(-2 * Constant.size.padding)
            })
            //Btn menu
            (stackNavi as! UIStackView).addArrangedSubview(self.btnBack)
            self.btnBack.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnBack.snp.height)
                maker.height.equalTo(Constant.size.btnIcon)
            })
            self.btnBack.setImage(UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnBack.tintColor = Constant.color.iconColor
            self.btnBack.contentMode = .scaleAspectFit
            //            self.btnMenu.backgroundColor = UIColor.blue
            
            //Ten lop
            (stackNavi as! UIStackView).addArrangedSubview(UIView())
            
            self.navigationView.addSubview(UIStackView(axis: .vertical, distribution: .fillEqually, alignment: .center, spacing: 0, design: nil), design: { (stackClass) -> (Void) in
                stackClass.snp.makeConstraints({ (maker) in
                    maker.center.equalToSuperview()
                    //                    maker.height.equalToSuperview()
                    
                })
                (stackClass as! UIStackView).addArrangedSubview(self.lblTitle)
                self.lblTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            })
            //Btn noti
            (stackNavi as! UIStackView).addArrangedSubview(self.btnSave)
            self.btnSave.snp.makeConstraints({ (maker) in
                maker.width.equalTo(self.btnSave.snp.height).multipliedBy(0.8)
                maker.height.equalTo(Constant.size.btnIcon)
            })
            
        }
    }
    func addCeparate(){
        self.view.addSubview(ceparateView)
        ceparateView.snp.makeConstraints { (maker) in
            maker.height.equalTo(1)
            maker.width.equalToSuperview()
            maker.top.equalTo(navigationView.snp.bottom)
            maker.centerX.equalToSuperview()
        }
        ceparateView.backgroundColor = UIColorFromRGB(rgbValue: 0x363636)
    }
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp.height).offset(-24)
            maker.width.equalTo(navigationView.snp.width).offset(-32)
            maker.top.equalTo(ceparateView.snp.bottom).offset(16)
            maker.centerX.equalTo(navigationView.snp.centerX)
        }
        searchView.addSubview(UIView(background: UIColorFromRGB(rgbValue: 0xf3f3f3), corner: Constant.size.avatarNormal / 2, border: 0, borderColor: Constant.color.separate, design: nil)) { (srcView) -> (Void) in
            srcView.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview()
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
            //add text field
            srcView.addSubview(self.txtSearch)
            self.txtSearch.snp.makeConstraints({ (maker) in
                maker.height.equalToSuperview().multipliedBy(0.7)
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(8)
                maker.right.equalToSuperview().offset(-8)
            })
            self.txtSearch.placeholder = "Nhập tên nhóm"
        }
    }
    func UIContentView(){
        self.view.addSubview(contenView)
        contenView.snp.makeConstraints { (maker) in
            maker.width.equalTo(searchView.snp.width)
            maker.top.equalTo(searchView.snp.bottom).offset(12)
            maker.bottom.equalToSuperview()
            maker.centerX.equalTo(searchView.snp.centerX)
        }
        //        chatView.backgroundColor = UIColor.red
        contenView.addSubview(lblMember)
        lblMember.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblMember.text = "Chọn"
        lblMember.font = UIFont(name:"HelveticaNeue-Bold", size: 16)
        contenView.addSubview(tbvContentView)
        tbvContentView.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.top.equalTo(lblMember.snp.bottom).offset(8)
            maker.height.equalToSuperview()
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
extension TNCreateGroupViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.size.rowHeightChat
    }
}
extension TNCreateGroupViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNCreateGroupCell.identify, for: indexPath) as! TNCreateGroupCell
        cell.selectionStyle = .none
        if (indexPath.row % 2 == 0) {
            cell.data = TNCreateGroupCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Tú Anh", content: "Phụ huynh")
        }
        else{
            cell.data = TNCreateGroupCellModel(avatar:UIImage(named: "ic_ava"), name: "Bố Tú Anh", content: "Phụ huynh")
        }
        return cell
    }
    
    
}
