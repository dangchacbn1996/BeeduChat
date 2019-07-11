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
    var btnSearch = UIButton(background: .clear, height: nil, ratioHW: nil, corner: 0, border: 0, borderColor: .clear, design: nil)
    var txtSearch = UITextField(background: .clear, corner: 0, border: 0, borderColor: .clear, design: nil)
    var ceparateView = UIView()
    var historyView = UIView()
    var NortificationView = UIView()
    var lblNortification = UILabel()
    var tbvNortification = UITableView()
    var tbvCellNoritfication = UITableView()
    var chatView = UIView()
    var tbvChat = UITableView()
    var lblChat = UILabel(text: "Chat", textColor: UIColor.black, font: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tbvChat.delegate = self
        tbvChat.dataSource = self
//        tbvChat.register(ChatGeneralCell.self, forCellReuseIdentifier: ChatGeneralCell.identify)
        tbvChat.register(CommentCell.self, forCellReuseIdentifier: ChatGeneralCell.identify)
        tbvChat.tableFooterView = UIView()
//        tbvChat.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tbvChat.separatorStyle = .none
        // Do any additional setup after loading the view.
    }

}
extension ChatViewController{
    func setupUI() {
        UINavBar()
        addCeparate()
        UISearchBar()
        UIHisContactBar()
        UINortification()
        UIChat()
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
        self.btnMenu.setImage(UIImage(named: "ic_menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnMenu.contentMode = .scaleAspectFit
//        btnMenu.backgroundColor = UIColor.blue
        //add stackview Tittle lalbe
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
        self.btnContact.setImage(UIImage(named: "ic_noti")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnContact.contentMode = .scaleAspectFit
//        btnContact.backgroundColor = UIColor.orange
        //add button Option
        stackView.addArrangedSubview(btnOption)
        btnOption.snp.makeConstraints { (maker) in
            maker.height.equalTo(btnOption.snp_width)
            maker.height.equalToSuperview().multipliedBy(0.8)
        }
        self.btnOption.setImage(UIImage(named: "ic_more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnOption.contentMode = .scaleAspectFit
//        btnOption.backgroundColor = UIColor.green
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
//        ceparateView.backgroundColor = UIColorFromRGB(rgbValue: 0x363636)
    }    //SearchBar
    func UISearchBar(){
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.height.equalTo(navigationView.snp_height)
            maker.width.equalTo(navigationView.snp_width)
            maker.top.equalTo(ceparateView.snp_bottom).offset(16)
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
//            self.btnSearch.backgroundColor = UIColor.red
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
//        var clvHistory: UICollectionView!
//        let layout = UICollectionViewFlowLayout()
//        clvHistory = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        layout.scrollDirection = .horizontal
        historyView.addSubview(UIView(background: UIColor.red, corner: 0, border: 0, borderColor: .clear, design: nil)) { (clvHistory) -> (Void) in
            clvHistory.snp.makeConstraints({ (maker) in
                maker.height.equalTo(48)
                maker.width.equalToSuperview()
                maker.center.equalToSuperview()
            })
//        clvHistory.snp.makeConstraints({ (maker) in
//            maker.height.equalTo(48)
//            maker.width.equalToSuperview()
//            maker.center.equalToSuperview()
//        })
        }
    }
    func UINortification(){
        self.view.addSubview(NortificationView)
        NortificationView.snp.makeConstraints { (maker) in
            maker.height.equalTo(56)
            maker.width.equalTo(navigationView.snp_width)
            maker.top.equalTo(historyView.snp_bottom).offset(16)
            maker.centerX.equalTo(historyView.snp_centerX)
        }
        NortificationView.backgroundColor = UIColor.red
        NortificationView.addSubview(lblNortification)
        lblNortification.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblNortification.text = "Thông báo"
        lblNortification.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        NortificationView.addSubview(tbvNortification)
        tbvNortification.snp.makeConstraints { (maker) in
            maker.top.equalTo(lblNortification.snp_bottom).offset(8)
            maker.left.equalToSuperview()
            maker.height.equalTo(48)
            maker.width.equalToSuperview()
        }
        
//        tbvNortification.backgroundColor = UIColor.green
        
    }
    func UIChat(){
        self.view.addSubview(chatView)
        chatView.snp.makeConstraints { (maker) in
            maker.width.equalTo(NortificationView.snp.width)
            maker.top.equalTo(NortificationView.snp.bottom)
            maker.bottom.equalToSuperview()
            maker.centerX.equalTo(NortificationView.snp.centerX)
        }
//        chatView.backgroundColor = UIColor.red
        chatView.addSubview(lblChat)
        lblChat.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview()
        }
        lblChat.text = "Chat"
        lblChat.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        chatView.addSubview(tbvChat)
        tbvChat.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview()
            maker.width.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.top.equalTo(lblChat.snp.bottom)
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

extension ChatViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return Constant.size.avatarNormal + 32
        return UITableView.automaticDimension
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatGeneralCell.identify, for: indexPath) as! ChatGeneralCell
        cell.selectionStyle = .none
        if (indexPath.row % 2 == 0) {
            cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "User", time: "12:30", content: "Swinging in the backyard\nPull up in your fast car\nWhistling my name", isRead: true)
        } else {
            cell.data = ChatGeneralModel(avatar: UIImage(named: "ic_ava"), name: "User", time: "12:30", content: "Content", isRead: false)
        }
        return cell
    }
    
}
