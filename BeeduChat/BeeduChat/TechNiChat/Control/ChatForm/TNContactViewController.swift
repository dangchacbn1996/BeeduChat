//
//  ContactViewController.swift
//  BeeduChat
//
//  Created by Pham Thang on 7/10/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import SnapKit

class TNContactViewController: UIViewController {
    var navigationView = UIView()
    var stackView = UIStackView(axis: .horizontal, distribution: .equalCentering, alignment: .center, spacing: 5, design: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
        tbvContent.register(TNContactCell.self, forCellReuseIdentifier: TNContactCell.identify)
        tbvContent.tableFooterView = UIView()
        tbvContent.tableHeaderView = UIView()
        tbvContent.separatorStyle = .singleLine
        tbvContent.delegate = self
        tbvContent.dataSource = self
        //su kien
        
        let edgeGes = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(goBack))
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    
    @objc func goBack(){
        Constant.animationTo(view: self, type: .dismiss)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func addFunction(){
        let view = TNActionSheetViewController()
        view.modalPresentationStyle = .overCurrentContext
        view.data = [TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1"),
                     TNActionModel(icon: UIImage(named: "ic_porfolio") ?? UIImage(), option: "Hành động 1", description: "Description 1")]
        self.present(view, animated: false, completion: nil)
    }
}
extension TNContactViewController{
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
        lblTitle.textColor = Constant.text.color.black
        lblTitle.font = lblTitle.font.withSize(32)
        stackView.addArrangedSubview(self.btnBack)
        btnBack.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview()
        }
        self.btnBack.setImage(UIImage(named: "ic_cancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnBack.imageView?.contentMode = .scaleAspectFit
        self.btnBack.tintColor = Constant.color.iconColor
        self.btnBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.goBack)))
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
                maker.height.equalTo(Constant.size.btnIcon)
                maker.centerY.equalToSuperview()
                maker.left.equalToSuperview().offset(8)
                
            })
//            self.btnSearch.backgroundColor = UIColor.red
            self.btnSearch.setImage(UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.btnSearch.tintColor = Constant.color.iconColor
            self.btnSearch.imageView?.contentMode = .scaleAspectFit
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
            maker.height.equalToSuperview()
            maker.width.equalTo(navigationView.snp.width)
            maker.top.equalTo(searchView.snp.bottom).offset(16)
            maker.centerX.equalTo(searchView.snp.centerX)
        }
//        contentView.backgroundColor = UIColor.red
        contentView.addSubview(lblContent)
        lblContent.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblContent.text = "Sắp xếp theo tên"
        lblContent.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        contentView.addSubview(btnDown)
        btnDown.snp.makeConstraints { (maker) in
            maker.left.equalTo(lblContent.snp.right)
        }
        self.btnDown.setImage(UIImage(named: "ic_down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnDown.contentMode = .scaleAspectFit
        self.btnDown.tintColor = Constant.color.iconColor
        contentView.addSubview(lblAdd)
        lblAdd.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview()
        }
        lblAdd.textColor = UIColorFromRGB(rgbValue: 0x4a658d)
        lblAdd.text = "Thêm"
        lblAdd.font = UIFont(name:"HelveticaNeue", size: 14)
        lblAdd.isUserInteractionEnabled = true
        lblAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addFunction)))
        contentView.addSubview(tbvContent)
        tbvContent.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblContent.snp.bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalToSuperview()
            maker.width.equalToSuperview()
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
extension TNContactViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.size.rowHeightChat
    }
}
extension TNContactViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TNContactCell.identify, for: indexPath) as! TNContactCell
        cell.selectionStyle = .none
        if (indexPath.row % 2 == 0)
        {
            cell.data = TNContactCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Tú Anh", content: "Phụ huynh")
        }else{
            cell.data = TNContactCellModel(avatar: UIImage(named: "ic_ava"), name: "Bố Thế Tân", content: "Phụ huynh")
        }
        return cell
    }
}
